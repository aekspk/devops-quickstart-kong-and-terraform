<!-- Run API Docker By Node version -->

FROM node:20-alpine

WORKDIR /app

# 1. ก๊อปปี้ไฟล์ระบุ Library (เหมือน COPY go.mod ...)

COPY package.json package-lock.json ./
RUN npm install

# 2. ก๊อปปี้โค้ดทั้งหมด (เหมือน COPY . .)

COPY . .

# 3. ขั้นตอนคอมไพล์ (เหมือน go build)

RUN npm run build

# 4. สั่งรันแอปที่คอมไพล์เสร็จแล้ว

CMD ["npm", "start"]

########################################################

<!-- docker build -t aekachai/devops-api:1.0 . -->

<!-- docker build: -->

<!-- เป็นคำสั่งหลักที่บอกให้ Docker Engine เริ่มอ่าน Dockerfile เพื่อสร้าง Image -->

<!-- -t (Tag): -->

<!-- ย่อมาจากคำว่า Tag ใช้สำหรับตั้งชื่อให้กับ Image ของเรา ถ้าไม่ใส่ตัวนี้ เราจะได้เลข ID ยาวๆ มาแทนซึ่งจำยากมาก -->

<!-- aekachai/devops-api:1.0: นี่คือชื่อที่เราตั้งให้ ซึ่งมีโครงสร้างมาตรฐานคือ: -->

<!-- aekachai: ชื่อเจ้าของ (Username) มักจะตั้งตามชื่อใน Docker Hub -->

<!-- devops-api: ชื่อของโปรเจกต์หรือแอป (Repository Name) -->

<!-- :1.0: เลขเวอร์ชัน (Tag Version) เพื่อบอกว่านี่คือเวอร์ชันแรก ถ้าเราแก้โค้ดแล้ว Build ใหม่ อาจจะเปลี่ยนเป็น :1.1 หรือ :latest -->

<!-- . (จุดสุดท้าย): สำคัญมากและห้ามลืม! -->

<!-- มันคือการบอก Build Context หรือบอก Docker ว่า "ให้มองหา Dockerfile และไฟล์ต่างๆ ที่จะ COPY อยู่ในโฟลเดอร์ปัจจุบันนี้นะ" -->
