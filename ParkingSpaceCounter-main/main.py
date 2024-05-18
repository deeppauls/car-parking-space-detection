import cv2
import pickle
import cvzone
import numpy
import numpy as np
from flask import Flask, request, jsonify




# global spaceCounter
# spaceCounter = 0



#Video feed
cap = cv2.VideoCapture("carPark.mp4")

with open("CarParkPos", "rb") as f:
    posList = pickle.load(f)

width, height = 107, 48

app = Flask(__name__)


@app.route("/")
def findSpaceCounter():
    # while True:
    #     # loop it current frame
    #     if cap.get(cv2.CAP_PROP_POS_FRAMES) == cap.get(cv2.CAP_PROP_FRAME_COUNT):
    #         cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
    #     success, img = cap.read()
    #
    #     imgGrey = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    #     imgBlur = cv2.GaussianBlur(imgGrey, (3, 3), 1)
    #     imgThreshold = cv2.adaptiveThreshold(imgBlur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 25,
    #                                          16)
    #     imgMedian = cv2.medianBlur(imgThreshold, 5)
    #
    #     kernel = numpy.ones((3, 3), np.uint8)
    #
    #     imgDilate = cv2.dilate(imgMedian, kernel, iterations=1)
    #
    #     checkParkingSpace(imgDilate)
    #
    #     # for pos in posList:
    #
    #     cv2.imshow("Image", img)
    #     # cv2.imshow("ImageGrey", imgGrey)
    #     # cv2.imshow("ImageBlur", imgBlur) #pixel count kam karna hai
    #     # cv2.imshow("ImageThresh", imgThreshold)
    #     # cv2.imshow("ImageMedian", imgMedian)
    #     # cv2.imshow("ImageDilate", imgDilate)
    #     cv2.waitKey(10)



    f = open("demofile.txt", "r")
    count = f.read()
    result = {
        "spaces": count
    }
    return jsonify(result), 200

@app.route('/spaces', methods=['POST'])
def findSpace():
    data = request.get_json()
    return jsonify(data), 201

if __name__ == "__main__":
    # flask_app = create_flask_app()
    app.run(debug=True)





def checkParkingSpace(imgPro):

    spaceCounter = 0

    for pos in posList:
        f = open("demofile.txt", "w")
        x, y = pos

        imgCrop = imgPro[y:y+height, x:x+width]
        # cv2.imshow(str(x+y), imgCrop)
        count = cv2.countNonZero(imgCrop)
        cvzone.putTextRect(img, str(count), (x, y+height-3), scale=1, thickness=2, offset=0)

        if count<900:
            color = (0, 255, 0)
            thickness = 3
            spaceCounter += 1
        else:
            color = (0, 0, 255)
            thickness = 2
        cv2.rectangle(img, pos, (pos[0] + width, pos[1] + height), color, thickness)
        cvzone.putTextRect(img, f'Free: {spaceCounter}/{len(posList)}', (100, 50), scale=3, thickness=5, offset=20, colorR=(0, 200, 0))
        f.write(str(spaceCounter))
    # return spaceCounter
        f.close()



while True:
    #loop it current frame
    if cap.get(cv2.CAP_PROP_POS_FRAMES) == cap.get(cv2.CAP_PROP_FRAME_COUNT):
        cap.set(cv2.CAP_PROP_POS_FRAMES, 0)
    success, img = cap.read()

    imgGrey = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    imgBlur = cv2.GaussianBlur(imgGrey, (3, 3), 1)
    imgThreshold = cv2.adaptiveThreshold(imgBlur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 25, 16)
    imgMedian = cv2.medianBlur(imgThreshold, 5)

    kernel = numpy.ones((3, 3), np.uint8)

    imgDilate = cv2.dilate(imgMedian, kernel, iterations=1)

    checkParkingSpace(imgDilate)

    # for pos in posList:

    cv2.imshow("Image", img)
    # cv2.imshow("ImageGrey", imgGrey)
    # cv2.imshow("ImageBlur", imgBlur) #pixel count kam karna hai
    # cv2.imshow("ImageThresh", imgThreshold)
    # cv2.imshow("ImageMedian", imgMedian)
    # cv2.imshow("ImageDilate", imgDilate)
    cv2.waitKey(10)



