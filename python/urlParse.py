from urllib import parse

origin = '문자열 URL 파싱'
encode = parse.quote(origin)
decode = parse.unquote(encode)

print('문자열 : ', origin)
print('encode : ', encode)
print('decode : ', decode)
