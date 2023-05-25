<!--
 * @Author: Melodyknit 2711402357@qq.com
 * @Date: 2023-05-25 16:24:20
 * @LastEditors: Melodyknit 2711402357@qq.com
 * @LastEditTime: 2023-05-25 16:33:38
 * @FilePath: README.md
 * @Description:
-->
# SQL-Template-Repository

## 教师表

| 字段名 | 数据类型 | 是否为空 | 约束条件 | 注释 |
| --- | --- | --- | --- | --- |
| id | INT | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY | 教师id |
| qq | BIGINT | NOT NULL | UNIQUE | 教师qq号 |
| name | VARCHAR(20) | NOT NULL | 无 | 教师姓名 |
| creator | VARCHAR(100) | NOT NULL | 无 | 谁邀请的 |
| phone | BIGINT | NOT NULL | UNIQUE | 教师电话 |
| email | VARCHAR(100) | NULL | UNIQUE | 教师邮箱 |

## 学院表

| 字段名 | 数据类型 | 是否为空 | 约束条件 | 注释 |
| --- | --- | --- | --- | --- |
| id | INT | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY | 学院id |
| college | VARCHAR(100) | NOT NULL | UNIQUE | 院系名称 |
| creator | VARCHAR(100) | NOT NULL | 无 | 添加人 |

## 专业表

| 字段名 | 数据类型 | 是否为空 | 约束条件 | 注释 |
| --- | --- | --- | --- | --- |
| id | INT | NOT NULL | UNIQUE AUTO_INCREMENT PRIMARY KEY | 专业id |
| college | INT | NOT NULL | FOREIGN KEY REFERENCES college(id)  | 学院id |
| major | VARCHAR(100) | NOT NULL | UNIQUE  | 专业名称 |
| creator  | VARCHAR(100)  | NOT NULL  | 无  | 添加人 |
