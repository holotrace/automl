使用说明
=======

## 1、安装运行环境

### 	1、一键自动安装

- **Linux**

  ```
  #解压文件在当前路径下
  ./linux_run.sh
  ```

  

- **Windows**

    ```
    解压文件, 双击windows_run.bat
    ```
    
    运行结束后会在解压的目录下创建schinper_env的虚拟环境

### 	2、手动安装

```
#解压文件在当前路径下
pip install -r requirements.txt -i https://pypi.doubanio.com/simple
```



## 2、运行模型脚本

```
激活虚拟环境
	1、windows: 在虚拟环境文件夹的Scripts下。激活：activate.bat
	2、linux: 在虚拟环境文件夹的bin下。激活：source activate
python [模型脚本路径] [模型训练时使用的数据集]
例如：
	python best_pipeline.py dataset.csv
```



## 3、注意事项

​	python版本推荐3.6~3.8		不支持3.9版本

