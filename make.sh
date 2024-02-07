docker pull nvidia/cuda:11.4.3-base-ubuntu20.04

while getopts "i:d:n:" opt; do
  case ${opt} in
    i ) IMAGE=${OPTARG};;
    n ) NAME=${OPTARG};;
    \? ) echo "Invalid option: -$OPTARG" 1>&2; exit 1;;
    : ) echo "Option -$OPTARG requires an argument." 1>&2; exit 1;;
  esac
done

echo "IMAGE: $IMAGE"
echo "NAME: $NAME"
echo "UID: $UID"

docker build -t ${IMAGE} --build-arg UNAME=${NAME} --build-arg UID=${UID} --build-arg GID=${UID} .
