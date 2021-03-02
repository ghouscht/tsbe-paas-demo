# Hello TSBE Cloud Function
<https://console.cloud.google.com/functions>

## Deploy / Test function
### 1. deploy function
```bash
gcloud compute regions list
gcloud functions deploy HelloTSBE --runtime go113 --trigger-http --allow-unauthenticated --region europe-west6
gcloud functions describe HelloTSBE
```

### 2. test function
<https://europe-west6-tsbe-306406.cloudfunctions.net/HelloTSBE>

```bash
curl https://europe-west6-tsbe-306406.cloudfunctions.net/HelloTSBE
curl -X POST -d '{"name":"Thomas"}' https://europe-west6-tsbe-306406.cloudfunctions.net/HelloTSBE
gcloud functions call HelloTSBE --region=europe-west6 --data '{"name":"Thomas"}'
```

### 3. update function
Uncomment `log.Println` lines in `hello.go` and update the function:

```bash
gcloud functions deploy HelloTSBE --runtime go113 --trigger-http --allow-unauthenticated --region europe-west6
gcloud functions describe HelloTSBE  --region europe-west6  # note that the versionId is no > 1
```

Repeat some of the tests to generate a few logs.

### 4. read Logs
```bash
gcloud functions logs read HelloTSBE --region europe-west6
```

### 5. cleanup
```bash
gcloud functions delete HelloTSBE --region europe-west6
gcloud functions list
```

## Questions
* Kann das go Programm auch lokal auf dem PC ausgeführt werden (sofern ein go Compiler installiert ist)? Warum?
* Was passiert nach dem Ende des http Requests (curl bzw. Aufrug mit dem Browser) mit der Funktion?
* Was versteht ihr unter dem Begriff "cold start"? Wie könnte dieser mit dem Begriff "function warming" zusammen hängen?

## More Infos
* [Pricing](https://cloud.google.com/functions/pricing#cloud_functions_pricing)
* [Overview](https://cloud.google.com/functions/docs)
* [Scaleability](https://cloud.google.com/functions/quotas#scalability)