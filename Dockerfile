# 기본 설정
FROM amazoncorretto:17

# 작업 디렉토리 설정
WORKDIR /app

# 필요한 파일 복사
COPY gradlew .
COPY gradle ./gradle
COPY src ./src
COPY build.gradle .
COPY settings.gradle .

# 애플리케이션 빌드
RUN ./gradlew clean build -x test

# 빌드된 JAR 파일 복사
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar

# 환경 변수 파일 복사
COPY application-secret.properties /path/in/container/application-secret.properties

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
