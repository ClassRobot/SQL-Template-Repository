-- Active: 1695720643069@@127.0.0.1@3306@classbot

CREATE DATABASE
    IF NOT EXISTS classbot DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE classbot;


-- 用户表

CREATE TABLE
    IF NOT EXISTS user (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '用户id',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        user_type VARCHAR(50) NOT NULL DEFAULT 'anonymous' COMMENT '用户类型[admin|teacher|student|anonymous]'
    ) COMMENT '用户总表';

-- 平台绑定表

CREATE TABLE
    IF NOT EXISTS bind (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '绑定id',
        user_id INT NOT NULL COMMENT '用户id',
        platform_id INT NOT NULL COMMENT '平台id',
        account_id VARCHAR(100) NOT NULL COMMENT '平台账号id',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '绑定时间',
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '绑定表';

-- 教师表

CREATE TABLE
    IF NOT EXISTS teacher (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '教师id',
        name VARCHAR(20) NOT NULL COMMENT '教师姓名',
        user_id INT NOT NULL UNIQUE COMMENT '用户id',
        creator INT NOT NULL COMMENT '谁邀请的',
        phone BIGINT NOT NULL UNIQUE COMMENT '教师电话',
        email VARCHAR(100) NULL UNIQUE COMMENT '教师邮箱',
        FOREIGN KEY (user_id) REFERENCES user(id),
        FOREIGN KEY (creator) REFERENCES user(id)
    ) COMMENT '教师表';

-- 学院表

CREATE TABLE
    IF NOT EXISTS college (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '学院id',
        college VARCHAR(100) NOT NULL UNIQUE COMMENT '院系名称',
        creator INT NOT NULL COMMENT '添加人',
        FOREIGN KEY (creator) REFERENCES user(id)
    ) COMMENT '学院表';

-- 专业表

CREATE TABLE
    IF NOT EXISTS major (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '专业id',
        college INT NOT NULL COMMENT '学院id',
        major VARCHAR(100) NOT NULL UNIQUE COMMENT '专业名称',
        creator INT NOT NULL COMMENT '添加人',
        FOREIGN KEY (college) REFERENCES college(id),
        FOREIGN KEY (creator) REFERENCES user(id)
    ) COMMENT '专业表';


CREATE TABLE
    IF NOT EXISTS bind_group (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '绑定群id',
        group_id BIGINT NOT NULL UNIQUE COMMENT '群号',
        platform_id VARCHAR(100) NOT NULL UNIQUE COMMENT '平台id',
        creator INT NOT NULL COMMENT '绑定人',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '绑定时间',
        FOREIGN KEY (creator) REFERENCES user(id)
    ) COMMENT '绑定群表';

-- 班级表

CREATE TABLE
    IF NOT EXISTS class_table (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '班级id',
        bind_group_id INT NOT NULL UNIQUE COMMENT '绑定的群组',
        name VARCHAR(100) NOT NULL UNIQUE COMMENT '班级群名',
        teacher_id INT NOT NULL COMMENT '教师id',
        major_id INT NOT NULL COMMENT '专业id',
        FOREIGN KEY (teacher_id) REFERENCES teacher(id),
        FOREIGN KEY (major_id) REFERENCES major(id),
        FOREIGN KEY (bind_group_id) REFERENCES bind_group(id)
    ) COMMENT '班级表';

-- 学生表

CREATE TABLE
    IF NOT EXISTS student (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '学生id',
        user_id INT NOT NULL UNIQUE COMMENT '用户id',
        name VARCHAR(20) NOT NULL COMMENT '学生姓名',
        class_table_id INT NOT NULL COMMENT '学生班级',
        teacher_id INT NOT NULL COMMENT '教师id',
        dorm_head INT NOT NULL DEFAULT 0 COMMENT '寝室长',
        position VARCHAR(50) NOT NULL DEFAULT '学生' COMMENT '学生',
        dorm VARCHAR(20) NULL COMMENT '寝室',
        student_id BIGINT NULL UNIQUE COMMENT '学号',
        phone BIGINT NULL UNIQUE COMMENT "联系方式",
        id_card VARCHAR(20) NULL UNIQUE COMMENT '身份证号',
        email VARCHAR(100) NULL UNIQUE COMMENT '邮箱',
        sex VARCHAR(10) NULL COMMENT '性别',
        class_order INT NULL COMMENT '个人在班级中的顺序',
        birthday TIMESTAMP NULL COMMENT '出生日期',
        ethnic VARCHAR(200) NULL COMMENT '民族',
        birthplace VARCHAR(200) NULL COMMENT '籍贯',
        politics VARCHAR(50) NULL COMMENT '政治面貌',
        address VARCHAR(200) NULL COMMENT '家庭住址',
        FOREIGN KEY (class_table_id) REFERENCES class_table(id),
        FOREIGN KEY (teacher_id) REFERENCES teacher(id),
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '学生表';

-- 德育日志

CREATE TABLE
    IF NOT EXISTS moral_education (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '德育日志id',
        class_table_id INT NOT NULL COMMENT '班级id',
        student_id INT NOT NULL COMMENT '学生id',
        activity_type VARCHAR(50) NULL COMMENT '分数类型',
        description TEXT NOT NULL COMMENT '解释原因原因',
        score INT NOT NULL DEFAULT 0 COMMENT '加减的分数',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日志时间',
        prove VARCHAR(255) NULL COMMENT "证明文件",
        FOREIGN KEY (class_table_id) REFERENCES class_table(id),
        FOREIGN KEY (student_id) REFERENCES student(id)
    ) COMMENT "德育日志";

-- 班级任务

CREATE TABLE
    IF NOT EXISTS class_tasks (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '任务id',
        title VARCHAR(255) NOT NULL COMMENT '任务标题',
        task_type VARCHAR(255) NOT NULL COMMENT '任务类型',
        class_table_id INT NOT NULL COMMENT '班级id',
        creator INT NOT NULL COMMENT '创建人',
        completed INT NOT NULL DEFAULT 0 COMMENT '是否已经完成',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        FOREIGN KEY (class_table_id) REFERENCES class_table(id),
        FOREIGN KEY (creator) REFERENCES user(id)
    ) COMMENT '班级任务表';

-- 任务文件

CREATE TABLE
    IF NOT EXISTS task_files (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '文件id',
        class_tasks_id INT NOT NULL COMMENT '收取标题',
        user_id INT NOT NULL COMMENT '提交人',
        file_md5 VARCHAR(255) NOT NULL COMMENT '文件名称md5',
        push_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
        FOREIGN KEY (class_tasks_id) REFERENCES class_tasks(id),
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '任务文件表';

-- 班费表

CREATE TABLE
    IF NOT EXISTS class_funds (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '班费id',
        class_table_id INT NOT NULL COMMENT '班级id',
        description TEXT NOT NULL COMMENT '费用所花费在某件事情',
        money DOUBLE NOT NULL COMMENT '花费金额',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
        user_id INT NOT NULL COMMENT '记录费用的用户',
        FOREIGN KEY (class_table_id) REFERENCES class_table(id),
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '班费表';

-- 学生会

CREATE TABLE
    IF NOT EXISTS student_council (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '学生会id',
        student_id INT NOT NULL COMMENT '学生qq',
        department VARCHAR(50) NOT NULL COMMENT '学生会部门',
        position VARCHAR(50) NOT NULL COMMENT '学生会职位',
        FOREIGN KEY (student_id) REFERENCES student(id)
    ) COMMENT '学生会表';

-- 反馈表

CREATE TABLE
    IF NOT EXISTS feedback (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '反馈id',
        user_id INT NOT NULL COMMENT '反馈人qq',
        content TEXT NOT NULL COMMENT '反馈内容',
        image_md5 VARCHAR(255) NULL COMMENT '反馈图片',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '反馈时间',
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '反馈表';

-- 通知表

CREATE TABLE
    IF NOT EXISTS notice (
        id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY COMMENT '通知id',
        class_table_id INT NOT NULL COMMENT '班级id',
        title VARCHAR(255) NOT NULL COMMENT '通知标题',
        content TEXT NOT NULL COMMENT '通知内容',
        create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '通知时间',
        user_id INT NOT NULL COMMENT '创建的用户id',
        notice_type VARCHAR(50) NOT NULL COMMENT '通知类型',
        at_user VARCHAR(255) NULL COMMENT '通知@的用户',
        FOREIGN KEY (class_table_id) REFERENCES class_table(id),
        FOREIGN KEY (user_id) REFERENCES user(id)
    ) COMMENT '通知表';