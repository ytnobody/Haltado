use inc::Module::Install;
name 'Haltado';
all_from 'lib/Haltado.pm';

requires 'Time::HiRes';
requires 'IO::File';
requires 'POSIX';
requires 'JSON';

requires 'Parse::Syslog::Line';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
