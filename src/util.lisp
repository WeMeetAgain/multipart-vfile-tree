(cl:in-package #:multipart-vfile-tree)

(defun clean-path (node)
  (let ((path (vfile-path node))
	(base (vfile-base node)))
    (urlencode
     (cond
       ((not path) "")
       ((not base) path)
       (t
	(when (not (char= (aref base (1- (length base))) #\/))
	  (setf base (format nil "~A/" base)))
	(setf path (regex-replace-all base path ""))
	(setf path (regex-replace-all "[\/]+" path "/"))
	(if (char= (aref path (1- (length path))) #\/)
	    (subseq path 0 (1- (length path)))
	    path))))))
