package com.codelab.theming.ui.start.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material.MaterialTheme
import androidx.compose.material.darkColors
import androidx.compose.material.lightColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

/*
    - 스타일을 중앙 집중화 하기 위해 MaterialTheme을 래핑하고 구성하는 자체 컴포저블을 만드는 것이 좋다.
    - 테마 맞춤 설정을 한곳에서 지정하고 재사용하기 좋다.
    - 여러 테마 컴포저블을 만들 수 있다.
 */

//  https://developer.android.com/reference/kotlin/androidx/compose/material/package-summary#lightColors(androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color,%20androidx.compose.ui.graphics.Color)
private val LightColors = lightColors(
    primary = Red700,
    primaryVariant = Red900,
    onPrimary = Color.White,
    secondary = Red700,
    secondaryVariant = Red900,
    onSecondary = Color.White,
    error = Red800
)

private val DarkColors = darkColors(
    primary = Red300,
    primaryVariant = Red700,
    onPrimary = Color.Black,
    secondary = Red300,
    onSecondary = Color.Black,
    error = Red200
)

@Composable
fun JetnewsTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colors = if (darkTheme) DarkColors else LightColors,
        typography = JetnewsTypography,
        shapes = JetnewsShapes,
        content = content
    )
}