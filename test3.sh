#!/bin/bash
declare -a ARRAY
#declare -a ARRAY2
echo “enter directory:”
read DIRECTORY
#echo “enter volume:”
#read VOLUME

to_array () {
   directory_name=$1
   local array_no=$2

   local array_var[0]
   local i=0

   for f in $(ls $directory_name)
     do 
       array_var[i]=$f
       ((i++))
     done
   if [ $array_no = 1 ]; then
   ARRAY=(${array_var[@]})
   fi
   
   if [ $array_no = 2 ]; then
   ARRAY2=(${array_var[@]}) 
   fi
}

#(1)directory_name : The path of the directory 
#(2)array_no : 1 or 2 representing ARRAY or ARRAY2 global. 

to_array $DIRECTORY 1

echo ${ARRAY[@]}
unset ARRAY[@]
echo  "############################################"
echo "second to_array:"
read DIRECTORY

to_array $DIRECTORY 1
echo ${ARRAY[@]}

echo  "#################################################"
echo "directory for array2:"
read HOME
to_array $HOME 2
echo ${ARRAY2[@]}


#echo ${ARRAY2[@]}

#echo ${#ARRAY[@]}
#echo ${ARRAY[0]}
