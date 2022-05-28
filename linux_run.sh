
#!/bin/bash

checkPython()
{
    V1=3
    V2=2
    V3=1
    echo need python version is : $V1.$V2.$V3

    U_V1=`python3 -V 2>&1|awk '{print $2}'|awk -F '.' '{print $1}'`
    U_V2=`python3 -V 2>&1|awk '{print $2}'|awk -F '.' '{print $2}'`
    U_V3=`python3 -V 2>&1|awk '{print $2}'|awk -F '.' '{print $3}'`

    echo your python version is : $U_V1.$U_V2.$U_V3

    if [ $U_V1 -lt $V1 ];then
        echo 'Your python version is not OK!(1)'
        exit 1
    elif [ $U_V1 -eq $V1 ];then
        if [ $U_V2 -lt $V2 ];then
            echo 'Your python version is not OK!(2)'
            exit 1
        elif [ $U_V2 -eq $V2 ];then
            if [ $U_V3 -lt $V3 ];then
                echo 'Your python version is not OK!(3)'
                exit 1
            fi
        fi
    fi

    echo Your python version is OK!
}
checkPython
{
        virtualenv schinper_env
} || {
        pip3 install virtualenv -i https://pypi.doubanio.com/simple
        virtualenv schinper_env
            }
source schinper_env/bin/activate
pip3 install -r requirements.txt -i https://pypi.doubanio.com/simple
        
python3 best_pipeline_20220527154931.py dataset_20220527154931.csv