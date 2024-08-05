//
//  RequestEntity.swift
//
//
//  Created by Vivek Topiya on 26/05/24.
//

import Foundation

/// Extension of ``HTTPEntity`` that also exposes the HTTP method and the
/// target URL. For use in the ``RestTemplate`` to prepare requests with.
public class RequestEntity<T>: HTTPEntity<T> {}
