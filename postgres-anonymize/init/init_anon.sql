ALTER DATABASE ilg SET session_preload_libraries = 'anon';
CREATE EXTENSION anon CASCADE;
SELECT anon.init();

-- Smoke test
SELECT anon.partial_email('daamien@gmail.com');
\! echo "==================== Anon Successfully installed ===================="
