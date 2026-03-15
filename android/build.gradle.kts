// Define repositories for all modules
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: customize the root build directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// Update build directory for each subproject
subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(name)
    layout.buildDirectory.set(newSubprojectBuildDir)
}

// ✅ Kotlin DSL-safe fix for missing namespace
subprojects {
    afterEvaluate {
        if (extensions.findByName("android") != null) {
            val androidExtension = extensions.getByName("android")
            if (androidExtension is com.android.build.gradle.BaseExtension) {
                if (androidExtension.namespace == null) {
                    androidExtension.namespace = "${project.group}.${project.name}"
                }
            }
        }
    }
}

// Force evaluation order if needed (optional)
subprojects {
    evaluationDependsOn(":app")
}

// Clean task to delete all build output
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
