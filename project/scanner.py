#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on: 2020-09-08.
Author: @daniel
"""
import cv2
import numpy as np


def mapp(h):
    h = h.reshape((4, 2))
    hnew = np.zeros((4, 2), dtype=np.float32)

    add = h.sum(1)
    hnew[0] = h[np.argmin(add)]
    hnew[2] = h[np.argmax(add)]

    diff = np.diff(h, axis=1)
    hnew[1] = h[np.argmin(diff)]
    hnew[3] = h[np.argmax(diff)]

    return hnew


image = cv2.imread("scanned-form.jpg")

image = cv2.resize(image, (1300, 800))
orig = image.copy()

gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# (5,5) is the kernel size and 0 is sigma that determines the amount of blur
blurred = cv2.GaussianBlur(gray, (5, 5), 0)

# 30 MinThreshold and 50 is the MaxThreshold
edged = cv2.Canny(blurred, 30, 50)

# Retrieve the contours as a list
contours, hierarchy = cv2.findContours(
    edged, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE
)
contours = sorted(contours, key=cv2.contourArea, reverse=True)

# Extract the boundary contours of the page
for c in contours:
    p = cv2.arcLength(c, True)
    approx = cv2.approxPolyDP(c, 0.02*p, True)

    if len(approx) == 4:
        target = approx
        break

# Find endpoints of the sheet
approx = mapp(target)

pts = np.float32([[0, 0], [500, 0], [500, 500], [0, 500]]
                 )  # map to 800*800 target window

op = cv2.getPerspectiveTransform(approx, pts)
dst = cv2.warpPerspective(orig, op, (500, 500))

cv2.imwrite("rectified.jpg", dst)

cv2.waitKey(0)
