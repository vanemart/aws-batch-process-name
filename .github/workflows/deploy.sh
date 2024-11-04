#!/bin/bash

ENVIRONMENT=$1
STACK_NAME="eventbridge-stack-$ENVIRONMENT"
PARAMETERS_FILE="parameters/$ENVIRONMENT.json"
TEMPLATE_FILE="templates/eventbridge_template.yaml"

if [ -z "$ENVIRONMENT" ]; then
  echo "Ambiente não especificado. Use dev, uat, ou prod."
  exit 1
fi

echo "Iniciando o deploy para o ambiente: $ENVIRONMENT"

aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file $TEMPLATE_FILE \
  --parameter-overrides file://$PARAMETERS_FILE \
  --capabilities CAPABILITY_NAMED_IAM \
  --region us-east-1

if [ $? -eq 0 ]; then
  echo "Deploy para $ENVIRONMENT concluído com sucesso."
else
  echo "Falha no deploy para $ENVIRONMENT."
  exit 1
fi
