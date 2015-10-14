(cl:in-package :multipart-vfile-tree)

(defclass multipart-vfile-node (vfile-node)
  ((%use-headers-p
    :initarg :use-headers-p
    :accessor multipart-use-headers-p
    :initform t)
   (%boundary
    :initarg :boundary
    :accessor multipart-vfile-boundary
    :initform (make-boundary))))

(defmethod multipart-headers ((n multipart-vfile-node))
  (list
   `("Content-Disposition" . ,(format nil "file; filename=~S" (clean-path n)))
   `("Content-Type" . ,(if (vfile-directory-p n)
			   (format nil "multipart/mixed; boundary=~A" (multipart-vfile-boundary n))
			   (format nil "application/octet-stream")))))

(defmethod multipart-stream ((n multipart-vfile-node))
  (vfile-open n))

(defmethod vfile-directory-open ((n multipart-vfile-node) &rest rest)
  (apply #'make-multipart-stream (multipart-vfile-boundary n) (vfile-children n)))

(defun make-multipart-vfile-tree (path &key (base (dirname path)) (recurse-p t) hidden-p)
  (traverse-filesystem path
		       (lambda (file)
			 (make-instance 'multipart-vfile-node
					:base base
					:directory-p nil
					:history (list file)
					:contents (pathname file)
					:children nil))
		       (lambda (directory subfiles)
			 (make-instance 'multipart-vfile-node
					:base base
					:directory-p t
					:history (list directory)
					:contents (pathname directory)
					:children subfiles))
		       :recurse-p recurse-p
		       :hidden-p hidden-p))
