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
include(mercurial.cmake)
ensure_hg_repo_is_current("https://bitbucket.org/eigen/eigen" "${CMAKE_CURRENT_SOURCE_DIR}/eigen" "3.2.0")


CPM_ExportAdditionalIncludeDir("${CMAKE_CURRENT_SOURCE_DIR}/eigen")
