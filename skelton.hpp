#ifndef	<+DINCLUSION+>
# define <+DINCLUSION+>

#include <iostream>

class <+CLASS+>{

private:

public:
	<+CLASS+>();
	<+CLASS+>(<+CLASS+> const &other);
	virtual ~<+CLASS+>();

	<+CLASS+>	&operator=(<+CLASS+> const &other);
};

std::ostream	&operator<<(std::ostream &o, <+CLASS+> const &c);

#endif
