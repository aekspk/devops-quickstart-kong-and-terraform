# เอา environment ของ golang:1.22.1 ซึ่งเป็น Docker image ใน docker hub ที่ set up + install Go มาใช้และกำหนดชื่อให้เป็น builder
FROM golang:1.22.1 AS builder

# ถ้าไม่มี folder /app จะสร้าง /app ขึ้นมาแล้ว cd ไปที่ /app
WORKDIR /app

# copy go.mod go.sum (คล้ายๆ package.json package-lock.json) และนำไปไว้ใน . ซึ่งหมายถึง directory ปัจจุบันคือ /app
COPY go.mod go.sum ./
RUN go mod download

# . ตัวแรกหมายถึง Copy เอาทุกอย่างใน file directory (build context . หลังสุดตอน build) ที่ Dockerfile อยู่ (/api) ยกเว้นใน .dockerignore
# . ตัวที่สองหมายถึง เอาค่าที่ Copy จาก . ตัวแรกมาไว้ใน directory ปัจจุบันใน container ซึ่งก่อนหน้านี้เรา WORKDIR /app แสดงว่าปัจจุบัน . หมายถึง /app
COPY . .
# สั่ง run build คล้ายๆ npm run build ของ node (สั่ง compile source code Go ให้กลายเป็น executable binary ชื่อ api)
RUN CGO_ENABLED=0 go build -o api

# เอา environment ของ alpine:3.19 ซึ่งเป็น Docker image ใน docker hub ของ Linux (Alpine) ที่เบาและเร็วมาก ถ้าลองเช็คจาก docker image ls ที่ build แล้วจะได้ final image จะเล็กกว่าใช้ golang image ตรง ๆ มาก เพราะมีแค่ Alpine กับ binary ที่ build แล้ว
FROM alpine:3.19 AS runner

# ถ้าไม่มี folder /app จะสร้าง /app ขึ้นมาแล้ว cd ไปที่ /app
WORKDIR /app

# Copy เอา binary ที่ build มาแล้ว (จะได้ไฟล์ ./api) จาก builder stage มาเก็บไว้ใน ./ หมายถึง directory ปัจจุบันก็คือ /app
COPY --from=builder /app/api ./

# สั่ง run go ที่ build ที่ build แล้ว (คล้ายๆ npm start) alpine:3.19 ต่อให้ไม่มี go ก็ run ได้เพราะ Go แปลงโค้ดเป็น “binary executable” มาแล้ว
CMD ["/app/api"]
