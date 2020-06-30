#!/bin/bash

# This shell script abstracts Mask R-CNN commands into
# 2 simple commands that can be run with little to
# no understanding of the underlying structure
# and configuration of detectron2.

# There are 3 "modes". Mask R-CNN can run inferencing on images, videos, or webcam.

# The user will provide up to 2 parameters in the command line, a FLAG and/or FILE.
# The command format is as follows:

# ./inference.sh --[FLAG] --[FILE]

# Parameters FLAG and FILE are as follows:

# FLAG:
# --image: Run inferencing on an image (REQUIRES FILE PARAMETER)
# --video: Run inferencing on a video (REQUIRES FILE PARAMETER)
# --webcam: Run inferencing on livestream from webcam (DOES NOT REQUIRE A FILE PARAMETER)

# FILE:
# The filename of the image or video to run inferencing on.
# If the file is NOT in the same directory as this script,
# provide a relative or full filepath.


if [ "$1" = "--webcam" ]; then
    python demo/demo.py --config-file configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml --webcam --opts MODEL.WEIGHTS detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl
    exit
fi


if [ "$1" = "--image" ]; then
	filename=$2
	if [ -e filename ]
	then
		python demo/demo.py --config-file configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml --input "$filename" --opts MODEL.WEIGHTS detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl
		# python demo/demo.py --config-file configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml --input "$filename" --opts MODEL.WEIGHTS "/home/jchoi/Projects/output/mcv_only_final.pth"
		exit
	else
		echo "ERROR: Filename $filename not found."
		exit
	fi
fi


if [ "$1" = "--video" ]; then
	filename=$2
	if [ -e filename ]
	then
	    python demo/demo.py --config-file configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml --video-input "$filename" --opts MODEL.WEIGHTS detectron2://COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x/137849600/model_final_f10217.pkl
	    # python demo/demo.py --config-file configs/COCO-InstanceSegmentation/mask_rcnn_R_50_FPN_3x.yaml --video-input "$filename" --opts MODEL.WEIGHTS "/home/jchoi/Projects/output/mcv_only_final.pth"
		exit
	else
		echo "ERROR: Filename $filename not found."
		exit
	fi
fi


echo "Please follow the proper input command format:"
echo "./inference.sh --webcam"
echo "OR"
echo "./inference.sh --[image/video] (image/video file name)"
exit
