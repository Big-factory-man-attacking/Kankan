cmake_minimum_required(VERSION 3.5)

project(Kankan-Demo LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(Kankan-Demo main.cpp cache.cpp cache.h comment.cpp comment.h commentbroker.cpp commentbroker.h commentinterface.h commentproxy.cpp commentproxy.h
		netizen.cpp netizen.h netizenbroker.cpp netizenbroker.h netizeninterface.h netizenproxy.cpp netizenproxy.h relationalbroker.cpp
		relationalbroker.h video.cpp video.h videobroker.cpp videobroker.h videofile.h videofile.cpp videofilebroker.cpp videofilebroker.h videofileinterface.h
		videofileinterface.h videofileproxy.cpp videofileproxy.h videointerface.h videoproxy.cpp videoproxy.h videosocialcontrol.cpp videosocialcontrol.h)

link_directories(/usr/lib)

target_link_libraries(Kankan-Demo mariadbcpp)

install(TARGETS Kankan-Demo
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
