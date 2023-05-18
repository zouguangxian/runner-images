Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

Describe "Java" {
    $toolsetJava = (Get-ToolsetContent).java
    $defaultVersion = $toolsetJava.default
    $defaultVendor = $toolsetJava.default_vendor
    $javaVendors = $toolsetJava.vendors

    [array]$jdkVersions = ($javaVendors | Where-Object {$_.name -eq $defaultVendor}).versions | ForEach-Object { @{Version = $_} }
    [array]$adoptJdkVersions = ($javaVendors | Where-Object {$_.name -eq "Adopt"}).versions | ForEach-Object { @{Version = $_} }

    It "Java <DefaultJavaVersion> is default" -TestCases @{ DefaultJavaVersion = $defaultVersion } {
        $arch = Invoke-Command -ScriptBlock { uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/'}
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_$($arch.ToUpper())"

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "javac" }
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    It "Gradle" {
        "gradle -version" | Should -ReturnZeroExitCode

        $gradleVariableValue = Get-EnvironmentVariable "GRADLE_HOME"
        $gradleVariableValue | Should -BeLike "/usr/share/gradle-*"

        $gradlePath = Join-Path $env:GRADLE_HOME "bin/gradle"
        "`"$GradlePath`" -version" | Should -ReturnZeroExitCode
    }

    It "Java <Version>" -TestCases $jdkVersions {
        $arch = Invoke-Command -ScriptBlock { uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/' }
        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${Version}_$($arch.ToUpper())"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin/java"

        "`"$javaPath`" -version" | Should -ReturnZeroExitCode

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
      "`"$javaPath`" -version" | Should -MatchCommandOutput ([regex]::Escape("openjdk version `"${Version}."))
    }

    It "Java Adopt <Version>" -TestCases $adoptJdkVersions -Skip:(Test-IsUbuntu22) {
        $arch = Invoke-Command -ScriptBlock { uname -m | sed -e 's/aarch64/arm64/' -e 's/x86_64/x64/' }
        $javaPath = Join-Path (Get-ChildItem ${env:AGENT_TOOLSDIRECTORY}\Java_Adopt_jdk\${Version}*) "${arch}\bin\java"
        "`"$javaPath`" -version" | Should -ReturnZeroExitCode

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
       "`"$javaPath`" -version" | Should -MatchCommandOutput ([regex]::Escape("openjdk version `"${Version}."))
    }
}
