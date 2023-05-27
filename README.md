# SQL-Template-Repository

## 教师表

| 字段名  | 数据类型     | 是否为空 | 约束条件                          | 注释     |
| ------- | ------------ | -------- | --------------------------------- | -------- |
| id      | INT          | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY | 教师id   |
| qq      | BIGINT       | NOT NULL | UNIQUE                            | 教师qq号 |
| name    | VARCHAR(20)  | NOT NULL | 无                                | 教师姓名 |
| creator | VARCHAR(100) | NOT NULL | 无                                | 谁邀请的 |
| phone   | BIGINT       | NOT NULL | UNIQUE                            | 教师电话 |
| email   | VARCHAR(100) | NULL     | UNIQUE                            | 教师邮箱 |

## 学院表

| 字段名  | 数据类型     | 是否为空 | 约束条件                          | 注释     |
| ------- | ------------ | -------- | --------------------------------- | -------- |
| id      | INT          | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY | 学院id   |
| college | VARCHAR(100) | NOT NULL | UNIQUE                            | 院系名称 |
| creator | VARCHAR(100) | NOT NULL | 无                                | 添加人   |

## 专业表

| 字段名  | 数据类型     | 是否为空 | 约束条件                           | 注释     |
| ------- | ------------ | -------- | ---------------------------------- | -------- |
| id      | INT          | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY  | 专业id   |
| college | INT          | NOT NULL | FOREIGN KEY REFERENCES college(id) | 学院id   |
| major   | VARCHAR(100) | NOT NULL | UNIQUE                             | 专业名称 |
| creator | VARCHAR(100) | NOT NULL | 无                                 | 添加人   |

## 班级表

| 列名     | 数据类型     | 约束                                          | 说明     |
| -------- | ------------ | --------------------------------------------- | -------- |
| id       | INT          | NOT NULL, UNIQUE, AUTO_INCREMENT, PRIMARY KEY | 班级id   |
| group_id | BIGINT       | NOT NULL, UNIQUE                              | 班级QQ群 |
| name     | VARCHAR(100) | NOT NULL, UNIQUE                              | 班级群名 |
| teacher  | INT          | NOT NULL, FOREIGN KEY                         | 教师id   |
| major    | INT          | NOT NULL, FOREIGN KEY                         | 专业id   |

## 学生表

| 列名 | 数据类型 | 约束 | 说明 |
| ------ | ------ | ------ | ------ |
| QQ | BIGINT | NOT NULL, UNIQUE, PRIMARY KEY | QQ |
| name | VARCHAR(20) | NOT NULL | 学生姓名 |
| class_table | INT | FOREIGN KEY (class_table) | 学生班级 |
| student_id | BIGINT | NULL, UNIQUE | 学号 |
| phone | BIGINT | NULL, UNIQUE | 联系方式 |
| id_card | VARCHAR(20) | NULL, UNIQUE | 身份证号 |
| wechat | VARCHAR(100) | NULL, UNIQUE | 微信号 |
| email | VARCHAR(100) | NULL, UNIQUE | 邮箱 |
| position | VARCHAR(50) | NOT NULL, DEFAULT '学生' | 学生 |
| sex | VARCHAR(10) | NULL | 性别 |
| class_order | INT | NULL | 个人在班级中的顺序 |
| birthday | TIMESTAMP | NULL | 出生日期 |
| dorm | VARCHAR(20) | NULL | 寝室 |
| dorm_head | BOOLEAN | NOT NULL, DEFAULT FALSE | 寝室长 |
| ethnic | VARCHAR(200) | NULL | 民族 |
| birthplace | VARCHAR(200) | NULL | 籍贯 |
| politics | VARCHAR(50)| NULL | 政治面貌 |
| address | VARCHAR(200) | NULL | 家庭住址 |

## 德育日志

| 列名 | 数据类型 | 约束 | 说明 |
| ------ | ------ | ------ | ------ |
| id | INT | NOT NULL, UNIQUE, AUTO_INCREMENT, PRIMARY KEY | 德育日志id |
| class_table | INT | FOREIGN KEY (class_table) | 班级id |
| qq | BIGINT | FOREIGN KEY (qq) | 学生qq |
| activity_type | VARCHAR(50) | NULL | 分数类型 |
| description | TEXT | NOT NULL | 解释原因原因 |
| score | INT | NOT NULL, DEFAULT 0 | 加减的分数 |
| create_at | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 日志时间 |
| prove | VARCHAR(255) | NULL | 证明文件 |

## 班级任务

| 列名 | 数据类型 | 约束 | 说明 |
| ------ | ------ | ------ | ------ |
| id | INT | NOT NULL, UNIQUE, AUTO_INCREMENT, PRIMARY KEY | 任务id |
| title | VARCHAR(255) | NOT NULL | 任务标题 |
| task_type | VARCHAR(255) | NOT NULL | 任务类型 |
| class_table | INT | FOREIGN KEY (class_table) | 班级id |
| creator | VARCHAR(100) | NOT NULL | 创建人 |
| completed | BOOLEAN | NOT NULL, DEFAULT FALSE | 是否已经完成 |
| create_time | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |

## 任务文件

| 列名 | 数据类型 | 约束 | 说明 |
| ------ | ------ | ------ | ------ |
| id | INT | NOT NULL, UNIQUE, AUTO_INCREMENT, PRIMARY KEY | 文件id |
| class_tasks | INT | FOREIGN KEY (class_tasks) | 任务id |
| student | BIGINT | FOREIGN KEY (student) | 提交人QQ |
| file_md5 | VARCHAR(255) | NOT NULL | 文件名称md5 |
| push_time | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 上传时间 |

## 班费表

| 列名 | 数据类型 | 约束 | 说明 |
| ------ | ------ | ------ | ------ |
| id | INT | NOT NULL, UNIQUE, AUTO_INCREMENT, PRIMARY KEY | 班费id |
| class_table | INT | FOREIGN KEY (class_table)  | 班级id |
| description | TEXT | NOT NULL | 费用所花费在某件事情 |
| money | DOUBLE | NOT NULL | 花费金额 |
| create_at | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 添加时间 |
| creator | VARCHAR(100) | NOT NULL | 费用记录人 |
