(cl:in-package :multipart-vfile-tree)

(defclass multipart-vfile-node (vfile-node)
  ((%use-headers-p
    :initarg :use-headers-p
    :accessor multipart-use-headers-p
    :initform t)))

(defclass multipart-vfile-directory-node (multipart-vfile-node vfile-directory-node)
  ((%boundary
    :initarg :boundary
    :accessor multipart-vfile-boundary
    :initform (make-boundary))))

(defmethod multipart-headers ((n multipart-vfile-node))
  (list
   `("Content-Disposition" . ,(format nil "file; filename=~S" (clean-path n)))
   '("Content-Type" . "application/octet-stream")))

(defmethod multipart-headers ((n multipart-vfile-directory-node))
  (list
   `("Content-Disposition" . ,(format nil "file; filename=~S" (clean-path n)))
   `("Content-Type" . ,(format nil "multipart/mixed; boundary=~A" (multipart-vfile-boundary n)))))

(defmethod multipart-stream ((n multipart-vfile-node))
  (vfile-open n))

(defmethod vfile-open ((n multipart-vfile-directory-node) &rest rest)
  (apply #'make-multipart-stream (multipart-vfile-boundary n) (vfile-children n)))

(defun make-multipart-vfile-tree (path &key (base (dirname path)) (recurse-p t) hidden-p)
  (traverse-filesystem path
		       (lambda (file)
			 (make-instance 'multipart-vfile-node
					:base base
					:history (list file)
					:contents (pathname file)))
		       (lambda (directory subfiles)
			 (make-instance 'multipart-vfile-directory-node
					:base base
					:history (list directory)
					:contents (pathname directory)
					:children subfiles))
		       :recurse-p recurse-p
		       :hidden-p hidden-p))
