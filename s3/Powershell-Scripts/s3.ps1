
# Prompt the user for AWS credentials
# $accessKey = Read-Host -Prompt "Enter AWS Access Key"
# $secretKey = Read-Host -Prompt "Enter AWS Secret Key"

# Set-AwsCredential  -AccessKey $accessKey -SecretKey $secretKey -StoreAs "Default"

$region = "us-east-1"
$bucketName = Read-Host -Prompt 'Enter s3 bucket Name'

Write-Host "AWS Region: $region"
Write-Host "Bucket Name : $bucketName"

#Create the Bucket if bucket does not exist 
if (Test-S3Bucket -BucketName $bucketName) {
    Write-Host "Bucket '$bucketName' already exists."
} else {
    # Create the S3 bucket if it doesn't exist
    New-S3Bucket -BucketName $bucketName -Region $region
    Write-Host "Bucket '$bucketName' created successfully in region '$region'."
}



#create a new file 
$fileName = 'MyFile.txt'
$fileContent = 'Hello World'

Set-Content -Path $fileName  -Value $fileContent


#Upload File to bucket 
Write-S3Object -BucketName $bucketName  -Key $fileName -File $fileName


#Delete Local File 
Remove-Item -Path $fileName
