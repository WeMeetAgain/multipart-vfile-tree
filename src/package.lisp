(cl:in-package #:cl-user)

(defpackage #:multipart-vfile-tree
  (:use #:cl)
  (:import-from #:cl-ppcre
                #:regex-replace-all)
  (:import-from #:multipart-stream
                #:multipart-stream
                #:multipart-headers
                #:multipart-use-headers-p
                #:make-multipart-stream
                #:make-boundary)
  (:import-from #:path-string
                #:dirname)
  (:import-from #:vfile
                #:vfile-base
                #:vfile-path
                #:vfile-open)
  (:import-from #:vfile-tree
                #:vfile-node
		#:vfile-directory-node
                #:vfile-directory-p
                #:vfile-children
                #:traverse-filesystem)
  (:export #:multipart-vfile-node
	   #:multipart-vfile-directory-node
           #:multipart-use-headers-p
           #:multipart-vfile-boundary
           #:make-multipart-vfile-tree))
