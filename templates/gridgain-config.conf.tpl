{
    ignite {
        clientConnector {
            connectTimeoutMillis:5000
            listenAddresses:[]
            metricsEnabled:true
            port:10800
            sendServerExceptionStackTraceToClient:false
            ssl {
                clientAuth:none
                enabled:${ssl_enabled}
                keyStore {
                    password:"${keystore_password }"
                    path:"/etc/gridgain9db/ssl/server.jks"
                    type:PKCS12
                }
            }
        }
        network {
            nodeFinder {
                netClusterNodes:[
                    "${cluster_dns}:3344"
                ]
            }
            port:3344
            ssl {
                clientAuth:none
                enabled:${ssl_enabled}
                keyStore {
                    password:"${keystore_password }"
                    path:"/etc/gridgain9db/ssl/server.jks"
                    type:"PKCS12"
                }
                trustStore {
                    password:"${keystore_password }"
                    path:"/etc/gridgain9db/ssl/server.jks"
                    type:"PKCS12"
                }
            }
        }
        rest {
            dualProtocol:false
            httpToHttpsRedirection:false
            port:10300
            ssl {
                clientAuth:none
                enabled:${ssl_enabled}
                port:10400
                keyStore {
                    type:"PKCS12"
                    path:"/etc/gridgain9db/ssl/server.jks"
                    password:"${keystore_password}"
                }
            }
        }
    }
}
