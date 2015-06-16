; Auto-generated. Do not edit!


(cl:in-package p2p-msg)


;//! \htmlinclude p2p_params.msg.html

(cl:defclass <p2p_params> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (go
    :reader go
    :initarg :go
    :type cl:integer
    :initform 0)
   (targetx
    :reader targetx
    :initarg :targetx
    :type cl:float
    :initform 0.0)
   (targety
    :reader targety
    :initarg :targety
    :type cl:float
    :initform 0.0))
)

(cl:defclass p2p_params (<p2p_params>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <p2p_params>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'p2p_params)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name p2p-msg:<p2p_params> is deprecated: use p2p-msg:p2p_params instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <p2p_params>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader p2p-msg:status-val is deprecated.  Use p2p-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'go-val :lambda-list '(m))
(cl:defmethod go-val ((m <p2p_params>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader p2p-msg:go-val is deprecated.  Use p2p-msg:go instead.")
  (go m))

(cl:ensure-generic-function 'targetx-val :lambda-list '(m))
(cl:defmethod targetx-val ((m <p2p_params>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader p2p-msg:targetx-val is deprecated.  Use p2p-msg:targetx instead.")
  (targetx m))

(cl:ensure-generic-function 'targety-val :lambda-list '(m))
(cl:defmethod targety-val ((m <p2p_params>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader p2p-msg:targety-val is deprecated.  Use p2p-msg:targety instead.")
  (targety m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <p2p_params>) ostream)
  "Serializes a message object of type '<p2p_params>"
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'go)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'targetx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'targety))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <p2p_params>) istream)
  "Deserializes a message object of type '<p2p_params>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'go) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'targetx) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'targety) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<p2p_params>)))
  "Returns string type for a message object of type '<p2p_params>"
  "p2p/p2p_params")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'p2p_params)))
  "Returns string type for a message object of type 'p2p_params"
  "p2p/p2p_params")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<p2p_params>)))
  "Returns md5sum for a message object of type '<p2p_params>"
  "fba86567c02b744e28b39fd3fcf3f986")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'p2p_params)))
  "Returns md5sum for a message object of type 'p2p_params"
  "fba86567c02b744e28b39fd3fcf3f986")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<p2p_params>)))
  "Returns full string definition for message of type '<p2p_params>"
  (cl:format cl:nil "int32 status~%int32 go~%float64 targetx~%float64 targety~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'p2p_params)))
  "Returns full string definition for message of type 'p2p_params"
  (cl:format cl:nil "int32 status~%int32 go~%float64 targetx~%float64 targety~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <p2p_params>))
  (cl:+ 0
     4
     4
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <p2p_params>))
  "Converts a ROS message object to a list"
  (cl:list 'p2p_params
    (cl:cons ':status (status msg))
    (cl:cons ':go (go msg))
    (cl:cons ':targetx (targetx msg))
    (cl:cons ':targety (targety msg))
))
