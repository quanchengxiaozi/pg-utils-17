SELECT
    CASE WHEN setting::bigint < 90400 THEN
        'You are using an old version of PostgreSQL, which is no longer supported by the community.' || chr(10) || 'We recommend you upgrade to the latest version as soon as possible.'
    WHEN setting::bigint < 90500 THEN
        'You are using an old version of PostgreSQL, which is still supported by the community.' || chr(10) || 'We recommend you upgrade to the latest version.'
    WHEN setting::bigint < 90600 THEN
        'You are using a relatively modern version of PostgreSQL, which is actively supported by the community.' || chr(10) || 'You are doing well, but you can update to the latest version if possible.'
    WHEN setting::bigint < 170400 THEN
        'You are using one of the latest versions of PostgreSQL.' || chr(10) || 'Everything is great.'
    ELSE
        'You are using a version that is in development,' || chr(10) || 'if this is production, we recommend you switch to a stable version of PostgreSQL.'
    END AS "Major PostgreSQL Version Check",
    CASE WHEN setting::bigint BETWEEN 170004 AND 170399
        OR setting::bigint BETWEEN 110003 AND 119999
        OR setting::bigint BETWEEN 100008 AND 109999
        OR setting::bigint BETWEEN 90613 AND 90699
        OR setting::bigint BETWEEN 90517 AND 90599
        OR setting::bigint BETWEEN 90422 AND 90499 THEN
        'You have one of the latest patches of PostgreSQL for your version.' || chr(10) || 'It looks like you are keeping up with PostgreSQL updates. This is a good fact.'
    ELSE
        'It looks like you have not updated PostgreSQL since installation/last major update at all.' || chr(10) || 'This is bad, we recommend you update to the latest version of PostgreSQL.'
    END AS "Minor PostgreSQL Version Check",
    'The current versions at the moment are as follows, in descending order of relevance:' || chr(10) || '17.4, 11.4, 10.9, 9.6.14, 9.5.18, 9.4.23' AS "List of Current Versions"
FROM
    pg_settings
WHERE
    name = 'server_version_num';
