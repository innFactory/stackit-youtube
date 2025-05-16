import express from 'express';
import * as redis from 'ioredis';

const app = express();
const port = 8080;
const redisClient = new redis.Redis("rediss://a9s-brk-usr-5d64cab22a5e628bfbd5e54321a77dbf888c04fd3c56c1e2dddfa:a9sa77164e7879e4120a280a2dbfbe814d705662de685fb5f085056c760fde67f@red40fb21-master-1.data.eu01.onstackit.cloud:49319", {
    tls: {
        servername: "red40fb21-master-1.data.eu01.onstackit.cloud",
    },
});
redisClient.on('error', (err) => console.log('Redis Client Error', err));

app.get('/', async (req, res) => {

    const RANDOM_NUMBER_KEY = 'random-number';
    let randomNumber: string | number = await redisClient.get(RANDOM_NUMBER_KEY);
    if (randomNumber === null || randomNumber === undefined) {
        // generate a random number between 0 and 8
        randomNumber = await superFancyRandomNumberGenerator();
        await redisClient.set(RANDOM_NUMBER_KEY, randomNumber);
        await redisClient.expire(RANDOM_NUMBER_KEY, 20);
    }

    const ttl = await redisClient.ttl(RANDOM_NUMBER_KEY);


    // fetch a random image from the image-service
    const response = await fetch(`https://image-service.apps.01.cf.eu01.stackit.cloud/${Number(randomNumber)}`)
    const presignedUrl = await response.text()
    res.send({ presignedUrl, randomNumber: Number(randomNumber), ttl });
});


async function superFancyRandomNumberGenerator() {
    // generate a random number between 0 and 8
    const randomNumber = Math.floor(Math.random() * 9);
    // simulate a long running process (sleep 2 seconds)
    await new Promise(resolve => setTimeout(resolve, 5000));
    return randomNumber;
}


app.listen(port, () => {
    return console.log(`server is listening on ${port}`);
});
