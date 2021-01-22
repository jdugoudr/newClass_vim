#include "<+CLASS+>.hpp"
#include <iostream>

<+CLASS+>::<+CLASS+>()
{
}

<+CLASS+>::<+CLASS+>(<+CLASS+> const &other)
{
	*this = other;
}

<+CLASS+>::~<+CLASS+>()
{
}

<+CLASS+>	&<+CLASS+>::operator=(<+CLASS+> const &other)
{
	if (this != &other)
	{
		//put here whatever make your object equal to an other
	}
	return *this;
}

<+FUNCTIONS+>

std::ostream	&operator<<(std::ostream &o, <+CLASS+> const &c)
{
	//use this to display a significant message;
	(void)c;
	return o;
}
