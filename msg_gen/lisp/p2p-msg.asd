
(cl:in-package :asdf)

(defsystem "p2p-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "p2p_params" :depends-on ("_package_p2p_params"))
    (:file "_package_p2p_params" :depends-on ("_package"))
  ))