#!/bin/bash -x

#backup3.sh: copies over files into backup drive.
#author: jshin

#notes to self: ----------------------------------------------------------------------------
#USB volume directories are located in /Volumes/
#directory depends on what specific directory, use pwd
#like /Users/username/desktop/dir
#when using on windows maybe check carefully for // when it comes to path ways

#Script designed for almost no loss of information.
#like Keeping old versions that I personally like to do when seeing what changes I made when I write stories.

#------------------------------------------------------------------------------------------


echo "enter directory to copy:"
read DIRECTORY

echo "enter volume or directory:"
read VOLUME

# ARRAY is for normal DIRECTORY files
# ARRAY2 is for normal VOLUME files

declare -a ARRAY
declare -a ARRAY2

#(1)directory_name : The path of the directory
#(2)array_no : 1 or 2 representing ARRAY or ARRAY2 global.
#Basic Description: puts regular files into one of the two global arrays.

to_array () {
    local directory_name=$1
    local array_no=$2

    local array_var[0]
    local i=0
    local j=0


    for f in $(ls $directory_name)
     do

    if [ -f $directory_name/$f ]; then
            array_var[i]=$f
            ((i++))
        fi
     done

    if [ $array_no = 1 ]; then
        ARRAY=(${array_var[@]})
    fi

    if [ $array_no = 2 ]; then
        ARRAY2=(${array_var[@]})
    fi


}


#Copies over the newest files over.
#if it doesn't exist it just copies it over.
#if it exists, version 2,3,4,... is copied over, and the name of the file is changed to whatever version it is.
#variable j is used to control the cp.

copy_func () {

local subDIRECTORY=$1
local subVOLUME=$2
for f in ${!ARRAY[@]}
do
  j=1    
  for g in ${!ARRAY2[@]}
    do
      if [ ${ARRAY[f]} = ${ARRAY2[g]} ]; then
             if [ $subDIRECTORY/${ARRAY[f]} -ot $subVOLUME/${ARRAY2[g]} ]; then
                  j=0
             elif [ $subDIRECTORY/${ARRAY[f]} -nt $subVOLUME/${ARRAY2[g]} ]; then
                  no=1 
                 until [ ! -e ${subVOLUME}/${ARRAY[f]}$no ]; do
                    ((no++))
                 done
                  cp $subDIRECTORY/${ARRAY[f]} $subVOLUME/${ARRAY[f]}$no
                  mv $subDIRECTORY/${ARRAY[f]} $subDIRECTORY/${ARRAY[f]}$no

                  j=0
             else 
                  j=0;
            fi
       fi
   done
       if [ $j -eq 1 ]; then
         cp ${subDIRECTORY}/${ARRAY[f]} ${subVOLUME}/${ARRAY[f]}
       fi
done

}

#Uses the power of Recursion to make things work!

powerhouse() {
    local subDIRECTORY=$1
    local subVOLUME=$2

     for f in $(ls $subDIRECTORY)
       do
            if [ -d $subDIRECTORY/$f ]; then
                if [ ! -e $subVOLUME/$f ]; then
                    cp -r $subDIRECTORY/$f $subVOLUME
                else
                    powerhouse $subDIRECTORY/$f  $subVOLUME/$f
                fi
            fi
       done

        to_array $subDIRECTORY 1
        to_array $subVOLUME 2
        copy_func $subDIRECTORY $subVOLUME
        unset ARRAY[@]
        unset ARRAY2[@]
}

powerhouse $DIRECTORY $VOLUME





