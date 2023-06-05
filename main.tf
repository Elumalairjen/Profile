provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "spring_boot_app" {
  function_name    = "spring-boot-app"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "com.example.Application::handleRequest"
  runtime          = "java11"
  filename         = "path/to/your/lambda-jar.jar"
  source_code_hash = filebase64sha256("path/to/your/lambda-jar.jar")
  memory_size      = 512
  timeout          = 10
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"
  
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
