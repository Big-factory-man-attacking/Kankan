//测试boost/uuid的相关用法
//参考网站：https://www.boost.org/doc/libs/1_79_0/libs/uuid/doc/uuid.html#Size

#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <iostream>
#include <typeinfo>

int main() {
	//生成128位长的数字，16个16进制的数字，每个数字的类型为uint_8(8位)
	boost::uuids::random_generator gen;
	boost::uuids::uuid id1 = gen();
	std::cout << typeid(id1).name() << std::endl;
	std::cout << "id1:" << id1  << std::endl;

	//利用给定的一个string生成一个uuid，必须是符合要求的字符串才能生成，
	//如用gen1(to_string(id1))结果与id1一致
	boost::uuids::string_generator gen1;
	boost::uuids::uuid id2 = gen1("{af5fed47-ea8b-4e78-82c8-4bead3855adb}");
	std::cout << "id2:" << id2 << std::endl;

	//将uuid转换为string
	std::string s = to_string(id2);
	std::cout << "id2(以字符串形式输出):" << s << std::endl;

	return 0;
}
