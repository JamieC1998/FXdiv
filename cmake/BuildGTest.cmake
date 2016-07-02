FUNCTION(build_gtest GTEST_SOURCE_DIR)
	INCLUDE(ExternalProject)
	SET(GTEST_INCLUDE_DIR ${GTEST_SOURCE_DIR}/include)
	ExternalProject_Add(GTest
		PREFIX gtest
		SOURCE_DIR ${GTEST_SOURCE_DIR}
		CMAKE_ARGS -Dgtest_force_shared_crt=ON -DBUILD_GTEST=ON
		INSTALL_COMMAND ""
		LOG_CONFIGURE ON
		LOG_BUILD ON)

	ADD_LIBRARY(gtest      UNKNOWN IMPORTED)
	ADD_LIBRARY(gtest_main UNKNOWN IMPORTED)

	ExternalProject_Get_Property(GTest BINARY_DIR)
	IF(NOT WIN32)
		SET_TARGET_PROPERTIES(gtest PROPERTIES IMPORTED_LOCATION ${BINARY_DIR}/libgtest.a)
		SET_TARGET_PROPERTIES(gtest_main PROPERTIES IMPORTED_LOCATION ${BINARY_DIR}/libgtest_main.a)
	ELSE()
		SET_TARGET_PROPERTIES(gtest PROPERTIES IMPORTED_LOCATION ${BINARY_DIR}/Debug/${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX})
		SET_TARGET_PROPERTIES(gtest_main PROPERTIES IMPORTED_LOCATION ${BINARY_DIR}/Debug/${CMAKE_STATIC_LIBRARY_PREFIX}gtest_main${CMAKE_STATIC_LIBRARY_SUFFIX})
	ENDIF()

	ADD_DEPENDENCIES(gtest      GTest)
	ADD_DEPENDENCIES(gtest_main GTest)

	SET(GTEST_ROOT ${GTEST_SOURCE_DIR} PARENT_SCOPE)
	SET(GTEST_INCLUDE_DIRS ${GTEST_INCLUDE_DIR} PARENT_SCOPE)
	SET(GTEST_BOTH_LIBRARIES gtest gtest_main PARENT_SCOPE)
	SET(GTEST_LIBRARIES gtest PARENT_SCOPE)
	SET(GTEST_MAIN_LIBRARIES gtest_main PARENT_SCOPE)
ENDFUNCTION(build_gtest)