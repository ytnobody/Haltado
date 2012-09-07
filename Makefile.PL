use inc::Module::Install;
name 'Haltado';
all_from 'lib/Haltado.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
