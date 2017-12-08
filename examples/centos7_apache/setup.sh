# Get public ip address, and add it to the terraform file.
echo "[ + ] Adding public IP address range to terraform variables file."
if [ ! "$(cat variables.tf | grep "default" -m 1 | awk -F "= " '{print $2}')" == "\"$(curl -qs icanhazip.com)/32\"" ]; then
  sed -i "1,/\"\"/ s/\"\"/\"$(curl -qs icanhazip.com)\/32\"/" variables.tf
fi


# Check Enviroment Variables
echo "[ + ] Checking AWS enviroment variables." 
if [ -z $AWS_DEFAULT_REGION ]; then
  echo "[ ! ] AWS_DEFAULT_REGION not set!"
  exit 1
fi

if [ -z $AWS_ACCESS_KEY_ID ]; then
  echo "[ ! ] AWS_ACCESS_KEY_ID not set!"
  exit 1
fi

if [ -z $AWS_SECRET_ACCESS_KEY ]; then
  echo "[ ! ] AWS_SECRET_ACCESS_KEY not set!"
  exit 1
fi

echo "Made with ♥ by Kent 'picat' Gruber"
