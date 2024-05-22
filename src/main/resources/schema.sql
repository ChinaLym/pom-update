create table if not exists tb_dependency
(
    id                          bigint auto_increment
        primary key,
    project_id                  bigint                            not null,
    group_id                    varchar(64)                       not null,
    artifact_id                 varchar(64)                       not null,
    version                     varchar(64)                       not null,
    new_version_notify_strategy varchar(32) default 'STABLE_ONLY' null
);

create table if not exists tb_notify_record
(
    id              bigint auto_increment
        primary key,
    project_id      bigint      null,
    group_id        varchar(64) null,
    artifact_id     varchar(64) null,
    current_version varchar(64) null,
    new_version     varchar(64) null,
    notified        tinyint(1)  null,
    notify_time     datetime    null
);

create table if not exists tb_project
(
    id          bigint auto_increment
        primary key,
    group_id    varchar(64)                  not null,
    artifact_id varchar(64)                  not null,
    version     varchar(64)                  null,
    name        varchar(128)                 null,
    description varchar(512)                 null,
    user_id     varchar(64)                  not null,
    status      varchar(16) default 'NOMARL' null,
    create_time datetime                     null,
    update_time datetime                     null
);

create table if not exists tb_third_project
(
    group_id               varchar(64)  not null,
    artifact_id            varchar(64)  not null,
    version                varchar(64)  null,
    stable_version         varchar(64)  null,
    name                   varchar(128) null,
    description            varchar(512) null,
    home_url               varchar(512) null,
    change_log_url         varchar(512) null,
    open_source_protocol   varchar(64)  null,
    stable_version_pattern varchar(64)  null,
    version_rule           varchar(32)  null,
    status                 varchar(32)  null,
    update_time            datetime     null,
    primary key (group_id, artifact_id)
);

create table if not exists tb_user
(
    id                                  varchar(64)  not null
        primary key,
    account                             varchar(32)  null,
    password                            varchar(128) null,
    name                                varchar(32)  null,
    email                               varchar(64)  null,
    phone                               varchar(16)  null,
    default_new_version_notify_strategy varchar(16)  not null,
    create_time                         datetime     null
);

