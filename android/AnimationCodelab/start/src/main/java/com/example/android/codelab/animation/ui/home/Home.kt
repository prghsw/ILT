/*
 * Copyright 2021 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example.android.codelab.animation.ui.home

import androidx.compose.animation.*
import androidx.compose.animation.core.*
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.awaitFirstDown
import androidx.compose.foundation.gestures.horizontalDrag
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.ExperimentalMaterialApi
import androidx.compose.material.FloatingActionButton
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Scaffold
import androidx.compose.material.Surface
import androidx.compose.material.TabPosition
import androidx.compose.material.TabRow
import androidx.compose.material.Text
import androidx.compose.material.TextButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBox
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.key
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.pointer.consumePositionChange
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.input.pointer.positionChange
import androidx.compose.ui.input.pointer.util.VelocityTracker
import androidx.compose.ui.res.stringArrayResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.heading
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.android.codelab.animation.R
import com.example.android.codelab.animation.ui.Amber600
import com.example.android.codelab.animation.ui.AnimationCodelabTheme
import com.example.android.codelab.animation.ui.Green300
import com.example.android.codelab.animation.ui.Green800
import com.example.android.codelab.animation.ui.Purple100
import com.example.android.codelab.animation.ui.Purple700
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlin.math.absoluteValue
import kotlin.math.roundToInt

private enum class TabPage {
    Home, Work
}

/**
 * Shows the entire screen.
 */
@Composable
fun Home() {
    // String resources.
    val allTasks = stringArrayResource(R.array.tasks)
    val allTopics = stringArrayResource(R.array.topics).toList()

    // The currently selected tab.
    var tabPage by remember { mutableStateOf(TabPage.Home) }

    // True if the whether data is currently loading.
    var weatherLoading by remember { mutableStateOf(false) }

    // Holds all the tasks currently shown on the task list.
    val tasks = remember { mutableStateListOf(*allTasks) }

    // Holds the topic that is currently expanded to show its body.
    var expandedTopic by remember { mutableStateOf<String?>(null) }

    // True if the message about the edit feature is shown.
    var editMessageShown by remember { mutableStateOf(false) }

    // Simulates loading weather data. This takes 3 seconds.
    suspend fun loadWeather() {
        if (!weatherLoading) {
            weatherLoading = true
            delay(3000L)
            weatherLoading = false
        }
    }

    // Shows the message about edit feature.
    suspend fun showEditMessage() {
        if (!editMessageShown) {
            editMessageShown = true
            delay(3000L)
            editMessageShown = false
        }
    }

    // Load the weather at the initial composition.
    LaunchedEffect(Unit) {
        loadWeather()
    }

    val lazyListState = rememberLazyListState()

    // The background color. The value is changed by the current tab.
    // tabPage는 State 객체로 지원되는 Int입니다.
    // 간단한 값 변경을 애니메이션으로 처리하려면 animate*AsState API를 사용하면 됩니다.
    // animateColorAsState로 래핑하여 애니메이션 값을 만들 수 있습니다.
    // 반환된 값은 State<T> 객체이므로 by 선언과 함께 로컬 위임 속성을 사용하여 일반 변수 처럼 사용 가능합니다.
    // TODO 1: Animate this color change.
//    val backgroundColor = if (tabPage == TabPage.Home) Purple100 else Green300
    val backgroundColor by animateColorAsState(targetValue = if (tabPage == TabPage.Home) Purple100 else Green300)

    // The coroutine scope for event handlers calling suspend functions.
    val coroutineScope = rememberCoroutineScope()
    Scaffold(
        topBar = {
            HomeTabBar(
                backgroundColor = backgroundColor,
                tabPage = tabPage,
                onTabSelected = { tabPage = it }
            )
        },
        backgroundColor = backgroundColor,
        floatingActionButton = {
            HomeFloatingActionButton(
                extended = lazyListState.isScrollingUp(),
                onClick = {
                    coroutineScope.launch {
                        showEditMessage()
                    }
                }
            )
        }
    ) { padding ->
        LazyColumn(
            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 32.dp),
            state = lazyListState,
            modifier = Modifier.padding(padding)
        ) {
            // Weather
            item { Header(title = stringResource(R.string.weather)) }
            item { Spacer(modifier = Modifier.height(16.dp)) }
            item {
                Surface(
                    modifier = Modifier.fillMaxWidth(),
                    elevation = 2.dp
                ) {
                    if (weatherLoading) {
                        LoadingRow()
                    } else {
                        WeatherRow(onRefresh = {
                            coroutineScope.launch {
                                loadWeather()
                            }
                        })
                    }
                }
            }
            item { Spacer(modifier = Modifier.height(32.dp)) }

            // Topics
            item { Header(title = stringResource(R.string.topics)) }
            item { Spacer(modifier = Modifier.height(16.dp)) }
            items(allTopics) { topic ->
                TopicRow(
                    topic = topic,
                    expanded = expandedTopic == topic,
                    onClick = {
                        expandedTopic = if (expandedTopic == topic) null else topic
                    }
                )
            }
            item { Spacer(modifier = Modifier.height(32.dp)) }

            // Tasks
            item { Header(title = stringResource(R.string.tasks)) }
            item { Spacer(modifier = Modifier.height(16.dp)) }
            if (tasks.isEmpty()) {
                item {
                    TextButton(onClick = { tasks.clear(); tasks.addAll(allTasks) }) {
                        Text(stringResource(R.string.add_tasks))
                    }
                }
            }
            items(count = tasks.size) { i ->
                val task = tasks.getOrNull(i)
                if (task != null) {
                    key(task) {
                        TaskRow(
                            task = task,
                            onRemove = { tasks.remove(task) }
                        )
                    }
                }
            }
        }
        EditMessage(editMessageShown)
    }
}

/**
 * Shows the floating action button.
 *
 * @param extended Whether the tab should be shown in its expanded state.
 */
// AnimatedVisibility is currently an experimental API in Compose Animation.
@Composable
private fun HomeFloatingActionButton(
    extended: Boolean,
    onClick: () -> Unit
) {
    // Use `FloatingActionButton` rather than `ExtendedFloatingActionButton` for full control on
    // how it should animate.
    FloatingActionButton(onClick = onClick) {
        Row(
            modifier = Modifier.padding(horizontal = 16.dp)
        ) {
            Icon(
                imageVector = Icons.Default.Edit,
                contentDescription = null
            )
            // Toggle the visibility of the content with animation.
            // if문을 사용하여 표시하거나 숨깁니다.
            // 이 가시성 변경에 애니메이션 효과를 적용하는 것은 if를 AnimatedVisibility 컴포저블로 대체합니다.
            // TODO 2-1: Animate this visibility change.
//            if (extended) {
//                Text(
//                    text = stringResource(R.string.edit),
//                    modifier = Modifier
//                        .padding(start = 8.dp, top = 3.dp)
//                )
//            }
            AnimatedVisibility(visible = extended) {
                Text(
                    text = stringResource(id = R.string.edit),
                    modifier = Modifier
                        .padding(start = 8.dp, top = 3.dp)
                )
            }
        }
    }
}

/**
 * Shows a message that the edit feature is not available.
 */
@Composable
private fun EditMessage(shown: Boolean) {
    // TODO 2-2: The message should slide down from the top on appearance and slide up on
    //           disappearance.
    /*
        들어가기 전환의 경우 initialOffsetY 매개변수 설정을 통해 항목의 전체 높이를 사용하도록 기본 동작을
        조정하여 올바르게 애니메이션이 적용되도록 할 수 있습니다. initialOffsetY는 초기 위치를 반환하는 람다여야 합니다.
        (람다는 인수 하나(요소 높이)를 수신합니다.)
        항목이 화면 상단에서 슬라이드 인되도록 음수 값을 반환합니다. 화면 상단의 값이 0이기 때문입니다.
        애니메이션이 -height에서 0(마지막 휴지 위치)으로 시작되어 위부터 애니메이션으로 나타나도록 하려고 합니다.
        slideInVertically를 사용하는 경우 슬라이드 인 후의 타겟 오프셋은 항상 0(픽셀)입니다. initialOffsetY는
        절대값으로 지정하거나 람다 함수를 통해 요소 전체 높이의 비율로 지정할 수 있습니다.
        마찬가지로 slideOutVertically는 초기 오프셋이 0이라고 가정하므로 targetOffsetY만 지정하면 됩니다.

        animationSpec 매개변수를 사용하여 애니메이션을 추가로 맞춤설정할 수 있습니다.
        animationSpec은 EnterTransition, ExitTransition 등 여러 Animation API의 공통 매개변수 입니다.
        다양한 AnimationSpec 유형 중 하나를 전달하여 시간이 지남에 따라 애니메이션 값을 어떻게 변경할지 지정할 수 있습니다.
        간단한 지속 기반 AnimationSpec을 사용합니다.
        tween 함수를 사용하여 만들 수 있습니다.
        durationMillis는 150ms이고 easing은 LinearOutSlowInEasing입니다.
        나가기 애니메이션의 경우 animationSpec 매개변수에 동일한 tween 함수를 사용하지만 durationMillis는 250ms이고 easing은 FastOutLinearInEasing입니다.
    */
    AnimatedVisibility(
        visible = shown,
        //  enter 매개변수는 EnterTransition 인스턴스 여야 한다.
        enter = slideInVertically(
            initialOffsetY = { fullHeight -> -fullHeight },
            animationSpec = tween(durationMillis = 150, easing = LinearOutSlowInEasing)
        ),
        exit = slideOutVertically(
            targetOffsetY = { fullHeight -> -fullHeight },
            animationSpec = tween(durationMillis = 250, easing = FastOutLinearInEasing)
        )
    ) {
        Surface(
            modifier = Modifier.fillMaxWidth(),
            color = MaterialTheme.colors.secondary,
            elevation = 4.dp
        ) {
            Text(
                text = stringResource(R.string.edit_message),
                modifier = Modifier.padding(16.dp)
            )
        }
    }
}

/**
 * Returns whether the lazy list is currently scrolling up.
 */
@Composable
private fun LazyListState.isScrollingUp(): Boolean {
    var previousIndex by remember(this) { mutableStateOf(firstVisibleItemIndex) }
    var previousScrollOffset by remember(this) { mutableStateOf(firstVisibleItemScrollOffset) }
    return remember(this) {
        derivedStateOf {
            if (previousIndex != firstVisibleItemIndex) {
                previousIndex > firstVisibleItemIndex
            } else {
                previousScrollOffset >= firstVisibleItemScrollOffset
            }.also {
                previousIndex = firstVisibleItemIndex
                previousScrollOffset = firstVisibleItemScrollOffset
            }
        }
    }.value
}

/**
 * Shows the header label.
 *
 * @param title The title to be shown.
 */
@Composable
private fun Header(
    title: String
) {
    Text(
        text = title,
        modifier = Modifier.semantics { heading() },
        style = MaterialTheme.typography.h5
    )
}

/**
 * Shows a row for one topic.
 *
 * @param topic The topic title.
 * @param expanded Whether the row should be shown expanded with the topic body.
 * @param onClick Called when the row is clicked.
 */
@OptIn(ExperimentalMaterialApi::class)
@Composable
private fun TopicRow(topic: String, expanded: Boolean, onClick: () -> Unit) {
    TopicRowSpacer(visible = expanded)
    Surface(
        modifier = Modifier
            .fillMaxWidth(),
        elevation = 2.dp,
        onClick = onClick
    ) {
        // TODO 3: Animate the size change of the content.
        /*
            Column 컴포저블은 콘텐츠가 변경되면 크기를 변경합니다.
            animateContentSize 수정자를 추가하여 크기 변경에 애니메이션을 적용할 수 있습니다.
            animateContentSize도 맞춤 animationSpec으로 맞춤 설정 할 수 있습니다.
        */
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
                .animateContentSize()
        ) {
            Row {
                Icon(
                    imageVector = Icons.Default.Info,
                    contentDescription = null
                )
                Spacer(modifier = Modifier.width(16.dp))
                Text(
                    text = topic,
                    style = MaterialTheme.typography.body1
                )
            }
            if (expanded) {
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = stringResource(R.string.lorem_ipsum),
                    textAlign = TextAlign.Justify
                )
            }
        }
    }
    TopicRowSpacer(visible = expanded)
}

/**
 * Shows a separator for topics.
 */
@Composable
fun TopicRowSpacer(visible: Boolean) {
    AnimatedVisibility(visible = visible) {
        Spacer(modifier = Modifier.height(8.dp))
    }
}

/**
 * Shows the bar that holds 2 tabs.
 *
 * @param backgroundColor The background color for the bar.
 * @param tabPage The [TabPage] that is currently selected.
 * @param onTabSelected Called when the tab is switched.
 */
@Composable
private fun HomeTabBar(
    backgroundColor: Color,
    tabPage: TabPage,
    onTabSelected: (tabPage: TabPage) -> Unit
) {
    TabRow(
        selectedTabIndex = tabPage.ordinal,
        backgroundColor = backgroundColor,
        indicator = { tabPositions ->
            HomeTabIndicator(tabPositions, tabPage)
        }
    ) {
        HomeTab(
            icon = Icons.Default.Home,
            title = stringResource(R.string.home),
            onClick = { onTabSelected(TabPage.Home) }
        )
        HomeTab(
            icon = Icons.Default.AccountBox,
            title = stringResource(R.string.work),
            onClick = { onTabSelected(TabPage.Work) }
        )
    }
}

/**
 * Shows an indicator for the tab.
 *
 * @param tabPositions The list of [TabPosition]s from a [TabRow].
 * @param tabPage The [TabPage] that is currently selected.
 */
@Composable
private fun HomeTabIndicator(
    tabPositions: List<TabPosition>,
    tabPage: TabPage
) {
    // TODO 4: Animate these value changes.
    /*
        복잡한 애니메이션을 만들 수 있는 Transition API
        Transition의 모든 애니메이션이 완료된 시점을 추적할 수 있습니다.
        animate*AsState는 추적 불가능 합니다.
        Transition 사용하면 여러 상태 간에 전환할 떄 다양한 transitionSpec을 정의 할 수 있습니다.

        여러 값에 동시에 애니메이션을 적용하려면 Transition을 사용하면 됩니다.
        Transition은 updateTransition함수를 사용하여 만들 수 있습니다. 현재 선택된 탭의 색인을 targetState 매개변수로 전달합니다.

        각 애니메이션 값은 Transition의 animate* 확장 함수를 사용하여 선언할 수 있습니다.
        animateDp 및 animateColor를 사용합니다. 람다 블록을 사용하므로 각 상태의 타겟 값을 지정할 수 있습니다.
        animate*함수가 State객체를 반환하므로 여기서 다시 by 선언을 사용하고 이를 로컬 위임 속성으로 만들 수 있습니다.

        transitionSpec 매개변수를 지정하여 애니메이션 동작을 맞춤설정할 수 있습니다.
        대상에 더 가까운 가장자리가 다른 가장자리보다 빠르게 움직이게 하여 표시기의 탄력 효과를 얻을 수 있습니다.
        transitionSpec 람다에서 isTransitioningTo 중위 함수를 사용하여 상태 변경 방향을 결정할 수 있습니다.

        ### Animation Preview (Start Animation Preview)를 클릭하여 대화형 모드를 시작할 수 있다.
        > https://developer.android.com/jetpack/compose/tooling#enable-experimental-features
     */
//    val indicatorLeft = tabPositions[tabPage.ordinal].left
//    val indicatorRight = tabPositions[tabPage.ordinal].right
//    val color = if (tabPage == TabPage.Home) Purple700 else Green800

    val transition = updateTransition(
        tabPage,
        label = "Tab indicator"
    )
    val indicatorLeft by transition.animateDp(
        transitionSpec = {
            if (TabPage.Home isTransitioningTo TabPage.Work) {
                spring(stiffness = Spring.StiffnessVeryLow)
            } else {
                spring(stiffness = Spring.StiffnessMedium)
            }
        },
        label = "Indicator left"
    ) { page ->
        tabPositions[page.ordinal].left
    }
    val indicatorRight by transition.animateDp(
        transitionSpec = {
             if (TabPage.Home isTransitioningTo TabPage.Work) {
                 spring(stiffness = Spring.StiffnessMedium)
             } else {
                 spring(stiffness = Spring.StiffnessVeryLow)
             }
        },
        label = "Indicator right"
    ) { page ->
        tabPositions[page.ordinal].right
    }
    val color by transition.animateColor(label = "Border color") { page ->
        if (page == TabPage.Home) Purple700 else Green800
    }

    Box(
        Modifier
            .fillMaxSize()
            .wrapContentSize(align = Alignment.BottomStart)
            .offset(x = indicatorLeft)
            .width(indicatorRight - indicatorLeft)
            .padding(4.dp)
            .fillMaxSize()
            .border(
                BorderStroke(2.dp, color),
                RoundedCornerShape(4.dp)
            )
    )
}

/**
 * Shows a tab.
 *
 * @param icon The icon to be shown on this tab.
 * @param title The title to be shown on this tab.
 * @param onClick Called when this tab is clicked.
 * @param modifier The [Modifier].
 */
@Composable
private fun HomeTab(
    icon: ImageVector,
    title: String,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Row(
        modifier = modifier
            .clickable(onClick = onClick)
            .padding(16.dp),
        horizontalArrangement = Arrangement.Center,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null
        )
        Spacer(modifier = Modifier.width(16.dp))
        Text(text = title)
    }
}

/**
 * Shows the weather.
 *
 * @param onRefresh Called when the refresh icon button is clicked.
 */
@Composable
private fun WeatherRow(
    onRefresh: () -> Unit
) {
    Row(
        modifier = Modifier
            .heightIn(min = 64.dp)
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(48.dp)
                .clip(CircleShape)
                .background(Amber600)
        )
        Spacer(modifier = Modifier.width(16.dp))
        Text(text = stringResource(R.string.temperature), fontSize = 24.sp)
        Spacer(modifier = Modifier.weight(1f))
        IconButton(onClick = onRefresh) {
            Icon(
                imageVector = Icons.Default.Refresh,
                contentDescription = stringResource(R.string.refresh)
            )
        }
    }
}

/**
 * Shows the loading state of the weather.
 */
@Composable
private fun LoadingRow() {
    /*
        애니메이션 반복
        InfiniteTransition 을 사용하여 반복적으로 애니메이션 처리.
        Transition API와 유사합니다. 둘 다 여러 값에 애니메이션을 적용하지만 Transition은 상태 변경에 따라 값에
        애니메이션을 적용하고 InfiniteTransition은 값에 무기한으로 애니메이션을 적용합니다.

        InfiniteTransition을 만들려면 rememberInfiniteTransition함수를 사용합니다.
        그런 다음 각 애니메이션 값 변경을 InfiniteTransition의 animate* 확장 함수 중 하나를 사용하여 선언할 수
        있습니다.
        여기서는 알파 값에 애니메이션을 적용하므로 animatedFloat를 사용하겠습니다. initialValue 매개변수는 0f여야
        하고, targetValue는 1f여야 합니다. 이 애니메이션의 AnimateSpec을 지정할 수도 있지만 이 API는
        InfiniteRepeatableSpec만 사용합니다.
        infiniteRepeatable 함수를 사용하여 만듭니다.
        이 AnimateSpec은 지속 시간 기반 AnimationSpec을 래핑하여 반복 가능하게 합니다.

        기본 repeatMode는 RepeatMode.Restart입니다.
        이 경우, 애니메이션이 initialValue에서 targetValue로 전환되고 initialValue에서 다시 시작됩니다.
        repeatMode를 RepeatMode.Reverse로 설정하면 애니메이션이 initialValue에서 targetValue로
        진행된 후 targetValue에서 initalValue로 진행됩니다. 애니메이션은 0에서 1까지 진행된 후 1에서 0으로
        진행됩니다.

        keyFrames 애니메이션은 다른 밀리초 단위에서 진행중인 값을 변경할 수 있는 또 다른 유형의 animationSpec
        (일부는 tween 및 spring)입니다. 처음에는 durationMillis를 1,000ms로 설정합니다. 그런 다음 애니메이션에서
        키프레임을 정의 할 수 있습니다. 예를 들어 애니메이션의 500ms에서 알파 값을 0.7f가 되도록 설정하려고 합니다.
        그러면 애니메이션의 진행률이 변경됩니다. 애니메이션의 500ms 내에서 0에서 0.7까지 빠르게 진행되고 애니메이션의 500ms에서
        1000ms까지는 0.7에서 1.0까지 천천히 속도를 줄이며 끝을 향해 진행됩니다.

        두 개 이상의 키프레임을 원하는 경우 여러 개를 정의할 수 있습니다.
     */
    // TODO 5: Animate this value between 0f and 1f, then back to 0f repeatedly.
    val infiniteTransition = rememberInfiniteTransition()
    val alpha by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(
            animation = keyframes {
                durationMillis = 1000
                0.7f at 500
//              0.9f at 800
            },
            repeatMode = RepeatMode.Reverse
        )
    )
//    val alpha = 1f
    Row(
        modifier = Modifier
            .heightIn(min = 64.dp)
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(48.dp)
                .clip(CircleShape)
                .background(Color.LightGray.copy(alpha = alpha))
        )
        Spacer(modifier = Modifier.width(16.dp))
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(32.dp)
                .background(Color.LightGray.copy(alpha = alpha))
        )
    }
}

/**
 * Shows a row for one task.
 *
 * @param task The task description.
 * @param onRemove Called when the task is swiped away and removed.
 */
@Composable
private fun TaskRow(task: String, onRemove: () -> Unit) {
    Surface(
        modifier = Modifier
            .fillMaxWidth()
            .swipeToDismiss(onRemove),
        elevation = 2.dp
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {
            Icon(
                imageVector = Icons.Default.Check,
                contentDescription = null
            )
            Spacer(modifier = Modifier.width(16.dp))
            Text(
                text = task,
                style = MaterialTheme.typography.body1
            )
        }
    }
}

/**
 * The modified element can be horizontally swiped away.
 *
 * @param onDismissed Called when the element is swiped to the edge of the screen.
 */
private fun Modifier.swipeToDismiss(
    onDismissed: () -> Unit
): Modifier = composed {
    /*
        터치 입력을 기반으로 애니메이션을 실행하는 방법
        ### 참고
        SwipeToDismiss는 자체 맞춤 수정자를 구현하는 대신 사용할 수 있는 Material의 컴포저블입니다.

        터치로 요소를 스와이프할 수 있도록 하는 수정자를 만들려고 합니다.
        요소가 화면 가장자리로 플링되면 요소가 삭제될 수 있도록 onDismissed 콜백을 호출합니다.

        swipeToDimiss 수정자를 빌드하려면 몇 가지 주요 개념을 알아야 합니다. 먼저 사용자가 화면에 손가락을 대면
        x 및 y 좌표가 있는 터치 이벤트가 발생되고 손가락을 오른쪽으로 이동하면 이동에 따라 x 및 y 좌표도 이동합니다.
        사용자가 터치하는 항목은 손가락에 따라 이동해야 하므로 터치 이벤트의 위치와 속도에 따라 항목의 위치가 업데이트됩니다.

        Compose 동작 문서
        >https://developer.android.com/jetpack/compose/gestures

        pointInput 수정자를 사용하면 수신되는 포인터 처치 이벤트에 대한 하위 수준 액세스 권한을 얻고 동일한 포인터를 사용하여
        사용자가 드래그하는 속도를 추적할 수 있습니다. 닫기 위한 경계를 항목이 지나기 전에 사용자가 손을 떼면 항목은 위치로 다시 돌아옵니다.

        시나리오에서 고려해야 할 사항. 첫째, 진행 중인 애니메이션이 터치 이벤트로 중단될 수 있습니다.
        둘째, 애니메이션 값이 유일한 정보 소스가 아닐 수도 있습니다. 즉, 애니메이션 값을 터치 이벤트에서 발생하는 값과
        동기화해야 할 수도 있습니다.

        Animatable은 지금까지 살펴본 API중 최저 수준의 API입니다. 동작 시나리오에서 유용한 여러 기능이 있습니다.
        동작에서 비롯되는 새로운 값으로 즉시 스냅하고 새 터치 이벤트가 트리거될 때 진행 중인 애니메이션을 중지하는 기능입니다.
        Animatable의 인스턴스를 만들고 이를 사용하여 스와이프할 수 있는 요소의 가로 오프셋을 나타내 보겠습니다.
     */
    // TODO 6-1: Create an Animatable instance for the offset of the swiped element.
    val offsetX = remember { Animatable(0f) }
    pointerInput(Unit) {
        // Used to calculate a settling position of a fling animation.
        val decay = splineBasedDecay<Float>(this)
        // Wrap in a coroutine scope to use suspend functions for touch events and animation.
        coroutineScope {
            while (true) {
                // Wait for a touch down event.
                val pointerId = awaitPointerEventScope { awaitFirstDown().id }
                // TODO 6-2: Touch detected; the animation should be stopped.
                /*
                    현재 실행 중인 경우 애니메이션을 중단해야 합니다. Animatable에서 stop을 호출하면 됩니다.
                    애니메이션이 실행되지 않는 경우 호출은 무시됩니다.
                    VelocityTracker는 사용자가 왼쪽에서 오른쪽으로 이동하는 속도를 계산하는 데 사용합니다.
                    awaitPointerEventScope는 사용자 입력 이벤트를 기다렸다가 이에 응답할 수 있는 정지 함수입니다.
                 */
                offsetX.stop()
                // Prepare for drag events and record velocity of a fling.
                val velocityTracker = VelocityTracker()
                // Wait for drag events.
                awaitPointerEventScope {
                    horizontalDrag(pointerId) { change ->
                        // TODO 6-3: Apply the drag change to the Animatable offset.
                        /*
                            드래그 이벤트를 계속 수신하고 있습니다. 터치 이벤트의 위치를 애니메이션 값에 동기화해야 합니다.
                            Animatable에서 snapTo를 사용하면 됩니다. snapTo는 다른 launch 블록 내에서 호출해야 합니다.
                            awaitPointerEventScope 및 horizontalDrag가 제한된 코루틴 범위이기 때문입니다.
                            즉, awaitPointerEvents의 경우에만 suspend 될 수 있습니다. snapTo는 포인터 이벤트가 아닙니다.
                         */
                        val horizontalDragOffset = offsetX.value + change.positionChange().x
                        launch {
                            offsetX.snapTo(horizontalDragOffset)
                        }
                        // Record the velocity of the drag.
                        velocityTracker.addPosition(change.uptimeMillis, change.position)
                        // Consume the gesture event, not passed to external
                        if (change.positionChange() != Offset.Zero) change.consume()
                    }
                }
                // Dragging finished. Calculate the velocity of the fling.
                val velocity = velocityTracker.calculateVelocity().x
                // TODO 6-4: Calculate the eventual position where the fling should settle
                //           based on the current offset value and velocity
                val targetOffsetX = decay.calculateTargetValue(offsetX.value, velocity)
                // TODO 6-5: Set the upper and lower bounds so that the animation stops when it
                //           reaches the edge.
                offsetX.updateBounds(
                    lowerBound = -size.width.toFloat(),
                    upperBound = size.width.toFloat()
                )
                launch {
                    // TODO 6-6: Slide back the element if the settling position does not go beyond
                    //           the size of the element. Remove the element if it does.
                    if (targetOffsetX.absoluteValue <= size.width) {
                        //  Not enough velocity; Slide Back.
                        offsetX.animateTo(targetValue = 0f, initialVelocity = velocity)
                    } else {
                        //  Enough velocity to slide away the element to the edge.
                        offsetX.animateDecay(velocity, decay)
                        //  The element was swiped away.
                        onDismissed()
                    }
                }
            }
        }
    }
        //  Apply the horizontal offset to the element.
        .offset {
            // TODO 6-7: Use the animating offset value here.
            IntOffset(offsetX.value.roundToInt(), 0)
        }
}

@Preview
@Composable
private fun PreviewHomeTabBar() {
    HomeTabBar(
        backgroundColor = Purple100,
        tabPage = TabPage.Home,
        onTabSelected = {}
    )
}

@Preview
@Composable
private fun PreviewHome() {
    AnimationCodelabTheme {
        Home()
    }
}
