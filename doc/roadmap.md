在不配置 email 情况下启动，以实现 docker run 更简单的参数

见：`MailSenderValidatorAutoConfiguration`

思路：排除这个类，并且注入自定义的 bean，检查是否能使用，不能使用时仅打印日志，不阻断启动。

