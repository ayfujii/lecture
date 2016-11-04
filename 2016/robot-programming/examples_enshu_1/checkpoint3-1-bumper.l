#!/usr/bin/env roseus

;; kobuki_msg::BumperEvent型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

;; ros::initする
(ros::roseus "bumper_subscriber")

;; コールバック関数を定義する
(defun bumper-cb (msg) (format t ";; bumper ~A is pressed!!~%" (send msg :bumper)))
(ros::subscribe
 "/mobile_base/events/bumper" ;; subscribeしたいtopicの名前
 kobuki_msgs::BumperEvent ;; subscribeしたいtopicの型
 #'bumper-cb ;; コールバック関数
 )

;; メインループ
(ros::rate 100) ;; 100[Hz]
(do-until-key
 (ros::spin-once)
 (ros::sleep)
 )
