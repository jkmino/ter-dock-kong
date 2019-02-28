# ter-dock-kong

prueba terraform+docker+kong 


1.- Modify the connection.tf file to configure the AWS API connection

  region                  = "us-west-2"
  shared_credentials_file = "CREDENTIAL-FILE-LOCATION"
  profile                 = "PROFILE-NAME"

  
2.- Run the script runall.sh with the dir path to the AWS .PEN KEY

sh runall.sh /home/user/AWSKEY.pem


