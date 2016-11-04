#!/usr/bin/env roseus

;; kobuki_msg::Sound型のmsgを使いたいので、kobuki_msgsというROSパッケージの必要ファイルをloadする
(ros::load-ros-manifest "kobuki_msgs")

;; ros::initする
(ros::roseus "led_publisher")

;; publishするtopicのadvertise
(ros::advertise
 "/mobile_base/commands/led1" ;; publishしたいtopic名
 kobuki_msgs::Led ;; publishしたいtopicの型
 1)

;; メインループ
(ros::rate 1)
(setq *led-count* 0)
(while (ros::ok)
  ;; soundのtopicを
  (let ((msg (instance kobuki_msgs::Led :init :value *led-count*)))
    (ros::ros-info "kobuki led [~A]" (send msg :value))
    (ros::publish "/mobile_base/commands/led1" msg)) ;; publishする
  (ros::sleep)
  (incf *led-count*)
  (if (> *led-count* 3) (setq *led-count* 0))
  )
(exit)
