type response
@val external fetch: string => promise<response> = "fetch"

module Response = {
  @send external arrayBuffer: response => promise<ArrayBuffer.t> = "arrayBuffer"
}
