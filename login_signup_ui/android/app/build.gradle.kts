plugins {
    id("com.android.application")
    id("kotlin-android") // Don't specify the version here
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.EasyReport"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"



    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.EasyReport"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

apply(plugin = "com.google.gms.google-services")
