# NewClass with VIM

This script provide a easy way to generate c++ canonical class using vim.

It is a little bit basic but can save you time when you have to create a lot of class one by one.

# Installation

Just copy "new_class.vim" file into your ~/.vim/plugin directory and template.cpp and template.hpp into ~/.vim/templates directory.

Then restart vim if a session was already open.

That's it.

# How it work

Start by creating your .hpp file (please use hpp extention).

In your empty file just press F4. It create the base structure of a canonincal class.

Now you can add your variables and functions members.

When you think you have all prototype you'll need, create .cpp file and press F4. The script create the base structure of a canonical class implementation and read your .hpp to add every functions you have.


You juste have to implement them now !

### Note

Please note that the class name will be base on the file name.

Test.hpp will create a class called Test.

Test.class.hpp will create a class called Test.class (this will be manage later).

hpp and cpp files HAVE to be the same name.

Test.hpp and Test.cpp work.

Test.hpp and Test.class.cpp will not work.

# Warning

This was just tested on a Xubuntu virtual machine. May have bug on other system.

Let me know.
