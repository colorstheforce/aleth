function(eth_apply TARGET REQUIRED)

	if (DEFINED ethereum_SOURCE_DIR)
		set(ETH_DIR ${ethereum_SOURCE_DIR})
		set(ETH_BUILD_DIR ${ethereum_BINARY_DIR})
	else ()
		set(ETH_DIR             "${PROJECT_SOURCE_DIR}/../cpp-ethereum"         CACHE PATH "The path to the cpp-ethereum directory")
		set(ETH_BUILD_DIR_NAME  "build"                                             CACHE STRING "The name of the build directory in cpp-ethereum")
		set(ETH_BUILD_DIR       "${ETH_DIR}/${ETH_BUILD_DIR_NAME}")
		set(CMAKE_LIBRARY_PATH 	${ETH_BUILD_DIR};${CMAKE_LIBRARY_PATH})
	endif()

	find_package(Eth)
	include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
	include_directories(${ETH_DIR})
	include_directories(${ETH_BUILD_DIR})
	target_link_libraries(${TARGET} ${Boost_THREAD_LIBRARIES})
	target_link_libraries(${TARGET} ${Boost_RANDOM_LIBRARIES})
	target_link_libraries(${TARGET} ${Boost_FILESYSTEM_LIBRARIES})
	target_link_libraries(${TARGET} ${Boost_SYSTEM_LIBRARIES})
	target_link_libraries(${TARGET} ${LEVELDB_LIBRARIES})	#TODO: use the correct database library according to cpp-ethereum
	target_link_libraries(${TARGET} ${CRYPTOPP_LIBRARIES})
	target_link_libraries(${TARGET} ${ETH_CORE_LIBRARIES})
	if (UNIX)
		target_link_libraries(${EXECUTABLE} pthread)
	endif()

	eth_copy_dlls(${TARGET} ${EVMJIT_DLLS})
	eth_copy_dlls(${TARGET} ${OpenCL_DLLS})
endfunction()
