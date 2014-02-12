cmake_minimum_required(VERSION 2.8.9 FATAL_ERROR)

set(CPM_MODULE_NAME eigen)

# initialize
if(NOT EXISTS ${CMAKE_CURRENT_BINARY_DIR}/init.cmake)
  file(DOWNLOAD https://raw.github.com/toeb/cpm/master/init-cpm-module.cmake ${CMAKE_CURRENT_BINARY_DIR}/init.cmake)
endif()
include(${CMAKE_CURRENT_BINARY_DIR}/init.cmake)

# All externals *must* define this.
CPM_ForceOnlyOneModuleVersion()

CPM_InitModule(${CPM_MODULE_NAME})

# include mercurial helpers and download eigen
CPM_EnsureRepoIsCurrent(
    TARGET_DIR "${CMAKE_CURRENT_SOURCE_DIR}/eigen"            # Required - Directory in which to place repository.
    HG_REPOSITORY "https://bitbucket.org/eigen/eigen"         # Git repository to clone and keep up to date.
    HG_TAG  "3.2.0"               # Git tag to checkout.   
    USE_CACHING 1              # Enables caching of repositories if the user 
                                 # has specified CPM_MODULE_CACHING_DIR.
                                 # Not enabled by default.
    )



CPM_ExportAdditionalIncludeDir("${CMAKE_CURRENT_SOURCE_DIR}/eigen")
