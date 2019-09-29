create schema if not exists public;

create table if not exists public.session
(
    user_id    bigint,
    token      varchar(256) not null,
    session_id varchar(256) not null,
    primary key (user_id)
);

create table if not exists public.news
(
    news_id    int primary key,
    news_date  date,
    news_title varchar,
    news_text  varchar
);

CREATE TABLE IF NOT EXISTS public.stories
(
    stories_id BIGINT,
    session_id VARCHAR(256),
    stories    VARCHAR NOT NULL,
    PRIMARY KEY (stories_id)
)
;