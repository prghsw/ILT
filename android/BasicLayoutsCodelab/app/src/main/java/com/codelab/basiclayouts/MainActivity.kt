/*
 * Copyright 2022 The Android Open Source Project
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

package com.codelab.basiclayouts

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyHorizontalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Spa
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.Role.Companion.Image
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.codelab.basiclayouts.ui.theme.MySootheTheme
import java.util.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent { MySootheApp() }
    }
}

// Step: Search bar - Modifiers
@Composable
fun SearchBar(
    /*  modifier를 매개변수로 받아 처리는 하는 것은 Compose 가이드 라인 권장 사항이다.
        https://android.googlesource.com/platform/frameworks/support/+/androidx-main/compose/docs/compose-api-guidelines.md#elements-accept-and-respect-a-modifier-parameter
        이 방식은 메서드의 호출자가 컴포저블 디자인과 분위기를 수정 할 수 있어 유연성이 높아지고 재사용이 가능하게 한다.
    */
    modifier: Modifier = Modifier
) {
    /*
        - 검색창 구현을 위해 TextField Material 구성요소를 사용한다.
        Compose Material Lib -> TextField 라는 Composable 이 존재.
        - modifier
            # 컴포저블의 크기, 레이아웃, 동작, 모양 변경.
            # 접근성 라벨과 같은 정보 추가.
            # 사용자 입력처리.
            # 요소를 클릭 가능, 스크롤 가능, 드래그 가능 또는 확대/축소 가능하게 만드는 것과 같은 높은 수준의 상호작용 추가.
     */
    TextField(
        value = "",
        onValueChange = {},
        modifier = modifier
            .fillMaxWidth()
            .heightIn(min = 56.dp),
        //  다른 컴포저블을 매개변수로 받을 수 있다. 내부에 Icon (Compose)을 설정.
        leadingIcon = {
              Icon(
                  imageVector = Icons.Default.Search,
                  contentDescription = null
              )
        },
        //  TextFieldDefaults.textFiledColors 특정 색상을 재정의 할 수 있다.
        colors = TextFieldDefaults.textFieldColors(
            backgroundColor = MaterialTheme.colors.surface
        ),
        //  설명 추가.
        placeholder = {
            Text(stringResource(id = R.string.placeholder_search))
        }
    )
}

// Step: Align your body - Alignment
@Composable
fun AlignYourBodyElement(
    //  이미지와 텍스트를 동적으로 처리.
    @DrawableRes drawable: Int,
    @StringRes text: Int,
    modifier: Modifier = Modifier
) {
    /*  상위 컨테이너 내부의 컴포저블 정렬은 상위 컨테이너의 alignment를 설정합니다.
        - Column
            Start
            CenterHorizontally
            End
        - Row
            Top
            CenterVertically
            Bottom
        - Box
            TopStart
            TopCenter
            TopEnd
            CenterStart
            Center
            CenterEnd
            BottomStart
            BottomCenter
            BottomEnd
        * align 수정자를 사용하여 단일 하위 요소의 동작을 재정의 할 수 있음.
    */
    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            painter = painterResource(drawable),
            contentDescription = null,
            /* 이미지 크기 조정 */
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .size(88.dp)
                /*
                    clip 수정자는 컴포저블의 모양을 조정 한다. 설정하면 도형에 맞춰 잘린다.
                    https://developer.android.com/reference/kotlin/androidx/compose/ui/graphics/Shape
                 */
                .clip(CircleShape)
        )
        Text(
            text = stringResource(id = text),
            style = MaterialTheme.typography.h3,
            modifier = Modifier.paddingFromBaseline(
                top = 24.dp, bottom = 8.dp
            )
        )
    }
}

// Step: Favorite collection card - Material Surface
@Composable
fun FavoriteCollectionCard(
    @DrawableRes drawable: Int,
    @StringRes text: Int,
    modifier: Modifier = Modifier
) {
    /* Surface는 Compose Material 라이브러리의 구성요소 입니다. 일반적인 Material Design 패턴을 따르며, 앱의 테암를
    * 변경 하여 조정 할 수 있습니다.
    * https://developer.android.com/codelabs/jetpack-compose-theming
    * https://developer.android.com/jetpack/compose/themes */
    Surface(
        //  shape > 모양을 설정한다. (MaterialTheme 사용함.)
        shape = MaterialTheme.shapes.small,
        modifier = modifier
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.width(192.dp)
        ) {
            Image(
                painter = painterResource(drawable),
                contentDescription = null,
                //  이미지 크기 조정
                contentScale = ContentScale.Crop,
                modifier = Modifier.size(56.dp)
            )
            Text(
                text = stringResource(id = text),
                style = MaterialTheme.typography.h3,
                modifier = Modifier.padding(horizontal = 16.dp)
            )
        }
    }
}

// Step: Align your body row - Arrangements
@Composable
fun AlignYourBodyRow(
    modifier: Modifier = Modifier
) {
    /* Compose에서는 LazyRow 컴포저블을 사용하여 스크롤 가능한 행을 구현할 수 있다.
        LazyRow는 모든 요소를 동시에 렌더링 하는 대신 화면에 표시되는 요소만 렌더링하여 앱의 성능을 유지 한다.
        https://developer.android.com/reference/kotlin/androidx/compose/foundation/lazy/package-summary#LazyRow(androidx.compose.ui.Modifier,androidx.compose.foundation.lazy.LazyListState,androidx.compose.foundation.layout.PaddingValues,kotlin.Boolean,androidx.compose.foundation.layout.Arrangement.Horizontal,androidx.compose.ui.Alignment.Vertical,androidx.compose.foundation.gestures.FlingBehavior,kotlin.Boolean,kotlin.Function1)
        https://developer.android.com/jetpack/compose/lists */
    LazyRow(
        //  컴테이너의 하위 요소 정렬
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        //  동일한 패딩을 유지하고, 상위목록의 경계 내에서 콘텐츠를 자르지 않고 스크롤 할 수 있도록 한다.
        contentPadding = PaddingValues(horizontal = 16.dp),
        modifier = modifier
    ) {
        //  LazyRow 하위 요소는 컴포저블이 아니다. 컴포저블을 목록 항목으로 내보내는 item, items 같은 메서드를 제공하는 Lazy 목록 DSL을 사용 한다.
        items(alignYourBodyData) { item ->
            AlignYourBodyElement(drawable = item.drawable, text = item.text)
        }
    }
}

// Step: Favorite collections grid - LazyGrid
@Composable
fun FavoriteCollectionsGrid(
    modifier: Modifier = Modifier
) {
    /*  항목 - 그리드 요소 매핑 (LazyHorizontalGrid)
        https://developer.android.com/reference/kotlin/androidx/compose/foundation/lazy/grid/package-summary#LazyHorizontalGrid(androidx.compose.foundation.lazy.grid.GridCells,androidx.compose.ui.Modifier,androidx.compose.foundation.lazy.grid.LazyGridState,androidx.compose.foundation.layout.PaddingValues,kotlin.Boolean,androidx.compose.foundation.layout.Arrangement.Horizontal,androidx.compose.foundation.layout.Arrangement.Vertical,androidx.compose.foundation.gestures.FlingBehavior,kotlin.Boolean,kotlin.Function1)
    */
    LazyHorizontalGrid(
        rows = GridCells.Fixed(2),
        contentPadding = PaddingValues(horizontal = 16.dp,vertical = 5.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp),
        modifier = modifier.height(120.dp)
    ) {
        items(favoriteCollectionsData) { item ->
            FavoriteCollectionCard(
                drawable = item.drawable,
                text = item.text,
                modifier = Modifier.height(56.dp)
            )
        }
    }
}

/*
    섹션 컨테이너를 구현하기 위해서는 슬롯 API를 사용한다.
    https://developer.android.com/jetpack/compose/layouts/basics#slot-based-layouts
    슬롯 기반 레이아웃은 개발자가 원하는 대로 채울 수 있도록 UI에 빈 공간을 남겨 둡니다.
    슬롯 기반 레이아웃을 사용하면 보다 유연한 레이아웃을 만들 수 있습니다.
 */
// Step: Home section - Slot APIs
@Composable
fun HomeSection(
    @StringRes title: Int,
    modifier: Modifier = Modifier,
    //  컴포저블 매개변수화. (슬롯)
    content: @Composable () -> Unit
) {
    /*
        컴포저블이 채울 수 있는 슬롯을 여러 개 제공한다면 더 큰 컴포저블 컨테이너에서 각각의 기능을
        나타내는 의미 있는 이름을 지정하면 됩니다.
        Material의 TopAppBar는 title, navigationIcon, actions 슬롯을 제공합니다.
    */
    Column(modifier) {
        Text(
            stringResource(title).uppercase(Locale.getDefault()),
            style = MaterialTheme.typography.h2,
            modifier = Modifier
                .paddingFromBaseline(top = 40.dp, bottom = 8.dp)
                .padding(horizontal = 16.dp)
        )
        content()
    }
}

/*
    Spacer를 사용하면 Column 내부에서 더 많은 공간을 확보 할 수 있다.
    Spacer를 사용하는 대신 Column의 패딩을 설정하면 Favorite collections에서 동일하게 잘라내기 동작이 적용된다.
*/
// Step: Home screen - Scrolling
@Composable
fun HomeScreen(modifier: Modifier = Modifier) {
    /*  기기 화면 크기에 따라 스크롤이 가능 하도록 개발. (Lazy 레이아웃)
      목록에 포함된 요소가 많거나 로드해야 할 데이터 세트가 많아서 모든 항목을 동시에 내보내면 성능이 저하되고 앱이 느려지게 되는 경우에 Lazy 레이아웃을 사용.
      목록에 포함된 요소의 개수가 많지 않은 경우에는 간단한 Column, Row를 사용하고 스크롤 동작을 수동으로 추가 한다.
      verticalScroll, horizontalScroll 수정자.
      이를 위해서는 스크롤의 현재 상태를 포함하여 외부에서 스크롤 상태를 수정하는 데 사용되는 ScrollState가 필요하다.
      여기서는 스크롤 상태를 수정할 필요가 없으므로 rememberScrollState를 사용하여 영구 ScrollState인스턴스를 만들면 된다.
      remember의 기능과 Compose 상태에서 맡은 역할의 내용 > https://developer.android.com/codelabs/jetpack-compose-state
    */
    Column(
        modifier
            .verticalScroll(rememberScrollState())
            .padding(vertical = 16.dp)
    ) {
//        Spacer(Modifier.height(16.dp))
        SearchBar(Modifier.padding(horizontal = 16.dp))
        HomeSection(title = R.string.align_your_body) {
            AlignYourBodyRow()
        }
        HomeSection(title = R.string.favorite_collections) {
            FavoriteCollectionsGrid()
        }
//        Spacer(modifier = Modifier.height(16.dp))
    }
}

// Step: Bottom navigation - Material
@Composable
private fun SootheBottomNavigation(modifier: Modifier = Modifier) {
    /*
        하단 탐색
        Compose Material 라이브러리의 일부인 BottomNavigation 컴포저블을 사용한다.
        컴포저블 내에서 하나 이상의 BottomNavigationItem 요소를 추가하면 Material 라이브러리에 의해 자동으로 스타일이 지정된다.
        Material Design에 관심이 있고 Jetpack Compose를 사용하여 디자인 시스템을 구현하는 방법
            > https://developer.android.com/codelabs/jetpack-compose-theming
            > https://developer.android.com/jetpack/compose/themes
    */
    BottomNavigation(modifier) {
        BottomNavigationItem(
            icon = {
                Icon(
                    imageVector = Icons.Default.Spa,
                    contentDescription = null
                )
            },
            label = {
                Text(text = stringResource(id = R.string.bottom_navigation_home))  
            },
            selected = true,
            onClick = { }
        )
        BottomNavigationItem(
            icon = {
                Icon(
                    imageVector = Icons.Default.AccountCircle,
                    contentDescription = null
                )
            },
            label = {
                Text(text = stringResource(id = R.string.bottom_navigation_profile))
            },
            selected = false,
            onClick = { }
        )
    }
}

// Step: MySoothe App - Scaffold
@Composable
fun MySootheApp() {
    /*
        https://developer.android.com/jetpack/compose/layouts/material#scaffold
        scaffold는 Material Design을 구현하는 앱을 위한 구성 가능한 최상위 수준 컴포저블 입니다.
        Material 개념의 슬롯이 포함되어 있는데, 그중 하나가 하단 메뉴이다.
     */
    MySootheTheme {
        Scaffold(
            bottomBar = { SootheBottomNavigation() }
        ) { padding ->
            HomeScreen(Modifier.padding(padding))
        }
    }
}

private val alignYourBodyData = listOf(
    R.drawable.ab1_inversions to R.string.ab1_inversions,
    R.drawable.ab2_quick_yoga to R.string.ab2_quick_yoga,
    R.drawable.ab3_stretching to R.string.ab3_stretching,
    R.drawable.ab4_tabata to R.string.ab4_tabata,
    R.drawable.ab5_hiit to R.string.ab5_hiit,
    R.drawable.ab6_pre_natal_yoga to R.string.ab6_pre_natal_yoga
).map { DrawableStringPair(it.first, it.second) }

private val favoriteCollectionsData = listOf(
    R.drawable.fc1_short_mantras to R.string.fc1_short_mantras,
    R.drawable.fc2_nature_meditations to R.string.fc2_nature_meditations,
    R.drawable.fc3_stress_and_anxiety to R.string.fc3_stress_and_anxiety,
    R.drawable.fc4_self_massage to R.string.fc4_self_massage,
    R.drawable.fc5_overwhelmed to R.string.fc5_overwhelmed,
    R.drawable.fc6_nightly_wind_down to R.string.fc6_nightly_wind_down
).map { DrawableStringPair(it.first, it.second) }

private data class DrawableStringPair(
    @DrawableRes val drawable: Int,
    @StringRes val text: Int
)

/*
*   @Preview 기능을 사용하여 코드를 수정 한 후 개별 컴포저블을 빠르게 확인 할 수 있다.
* */
@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun SearchBarPreview() {
    MySootheTheme { SearchBar(Modifier.padding(8.dp)) }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun AlignYourBodyElementPreview() {
    MySootheTheme {
        AlignYourBodyElement(
            R.drawable.ab1_inversions,
            R.string.ab1_inversions,
            modifier = Modifier.padding(8.dp)
        )
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun FavoriteCollectionCardPreview() {
    MySootheTheme {
        FavoriteCollectionCard(
            R.drawable.fc2_nature_meditations,
            R.string.fc2_nature_meditations,
            modifier = Modifier.padding(8.dp)
        )
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun FavoriteCollectionsGridPreview() {
    MySootheTheme { FavoriteCollectionsGrid() }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun AlignYourBodyRowPreview() {
    MySootheTheme { AlignYourBodyRow() }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun HomeSectionPreview() {
    MySootheTheme {
        HomeSection(R.string.align_your_body) {
            AlignYourBodyRow()
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2, heightDp = 180)
@Composable
fun ScreenContentPreview() {
    MySootheTheme { HomeScreen() }
}

@Preview(showBackground = true, backgroundColor = 0xFFF0EAE2)
@Composable
fun BottomNavigationPreview() {
    MySootheTheme { SootheBottomNavigation(Modifier.padding(top = 24.dp)) }
}

@Preview(widthDp = 360, heightDp = 640)
@Composable
fun MySoothePreview() {
    MySootheApp()
}
