use inc::Module::Install;
name 'Haltado';
all_from 'lib/Haltado.pm';

# Haltado.pm
requires 'Time::HiRes';
requires 'IO::File';
requires 'POSIX';
requires 'JSON';

# Parser::Syslog
requires 'Parse::Syslog::Line';

# Parser::AccessLog
requires 'Parse::AccessLogEntry';

# Action::ToJSON
requires 'JSON';

# Action::Throw::HTTP
requires 'Furl';
requires 'HTTP::Request::Common';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
